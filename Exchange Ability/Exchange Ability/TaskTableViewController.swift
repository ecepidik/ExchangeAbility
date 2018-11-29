//
//  TaskTableViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
//    @IBOutlet var taskTable: UITableView!
    var allTasks : [Task] = [Task]()
    

    override func viewWillAppear(_ animated: Bool) {
        
        print("We are here!")
        self.allTasks = [Task]();
//        var sampleTask = Task(requestor: myUser.requestor!)
//        sampleTask.title = "Snow Shovel"
//        sampleTask.category = Task.Category.snowRemoval
//        sampleTask.fee = 10.0
//        sampleTask.description = "I have a large driveway I would like shoveled"
//        sampleTask.dateTime = Date()
//        sampleTask.location = "3514 Rue Hutchison"
//        sampleTask.state = Task.State.opened
//        self.allTasks.append(sampleTask)

        var loadingTasks = [Task]();
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global().sync {

            APIService().getTasks() { tasks in
                for item in tasks{
					// get requestor
					let requestorId : Int = item["requesterid"] as! Int
					let requestor = getUserDatabase(uid: requestorId)
					let requestorUser = requestor.requestor

					let newTask: Task = Task(requestor: requestorUser!);

                    let stateString = item["state"] as! String
                    switch stateString {
                    case "open":
                        newTask.state = Task.State.opened
                    case "completed":
                        newTask.state = Task.State.completed
                    case "pendingCompleted":
                        newTask.state = Task.State.pendingCompleted
                    case "assigned":
                        newTask.state = Task.State.assigned
                    case "cancelled":
                        newTask.state = Task.State.cancelled
                    default:
                        newTask.state = Task.State.pending
                    }


                    newTask.title = item["title"] as! String
                    newTask.fee = item["fee"] as! Double
                    newTask.description = item["description"] as! String
                    newTask.location = item["address"] as! String
					// TODO parse date and provider

					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
					guard let date = dateFormatter.date(from: item["date"] as! String) else {
						fatalError("ERROR: Date conversion failed due to mismatched format.")
					}

					newTask.dateTime = date
//					newTask.provider = (getUserDatabase(uid: (item["providerid"] as? Int)?)).provider

                    loadingTasks.append(newTask)
//                    print(newTask.id)
                }
                
                self.allTasks = [Task]();
                
                for task in loadingTasks {
                    self.allTasks.append(task)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
//                print(tasks)
            }
            
//            group.leave()
        }
        
        DispatchQueue.global().sync {
//            print(allTasks);
            super.viewWillAppear(animated)
        }
        
//        group.notify(queue: .global()) {
//            print(allTasks);
//            super.viewWillAppear(animated)
//        }
    }
    
    override func viewDidLoad() {
        tableView.reloadData()
        super.viewDidLoad()

		        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTasks.count
    }

	let cellIdentifier = "TaskTableViewCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell  else {
			fatalError("The dequeued cell is not an instance of TaskTableViewCell.")
		}
        
//        print("First all Task Count: ", allTasks.count)
//        print("First index row Count: ", indexPath.row)
        if(self.allTasks.count <= indexPath.row) {
            
            let numberToAdd = indexPath.row + 1 - self.allTasks.count
            let sampleTask = Task(requestor : myUser.requestor!)
            
            for i in 0...(numberToAdd) {
                allTasks.append(sampleTask)
            }
        }

//        print("allTasks.count: ", allTasks.count)
//        print("indexPath.row: ", indexPath.row)
        
		let task = self.allTasks[indexPath.row]

		cell.titleLabel.text = task.title
        cell.fee.text = "$" + String(format:"%.2f", task.fee)
//		cell.Category.text = task.category.rawValue
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE, MMM d @ h:mm a"
		let date = dateFormatter.string(from: task.dateTime)
		cell.Date.text = date
//		cell.Date.text = String(describing: task.dateTime)
        cell.location.text = task.location

		return cell
    }

	@IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
		if let view = view as? UITableView {
			view.reloadData();
		}
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	// MARK: Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueTask" {

			let task = self.allTasks[((view as! UITableView).indexPathForSelectedRow!.row)]

			// Create an instance of PlayerTableViewController and pass the variable
			let destinationVC = segue.destination as! TaskViewController
			destinationVC.task = task

		}
	}

}

