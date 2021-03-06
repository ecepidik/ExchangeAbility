//
//  AssignedTableViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-10-24.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class AssignedTableViewController: UITableViewController {

//    var assignedTasks : [Task] = [Task]()

	override func viewWillAppear(_ animated: Bool) {
        
        var loadingTasks = [Task]();
        
        myUser.provider?.tasks = [Task]()

		let group = DispatchGroup()
		group.enter()

		DispatchQueue.global().sync {

			APIService().getproviderTasks(providerID: Int(myUser.uid)!) { tasks in
				for item in tasks{
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

					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
					guard let date = dateFormatter.date(from: item["date"] as! String) else {
						fatalError("ERROR: Date conversion failed due to mismatched format.")
					}
					
					newTask.dateTime = date

					//newTask.dateTime = item["date"] as! Date

                    loadingTasks.append(newTask);
//                    myUser.provider?.tasks.append(newTask);
					print(newTask.id)
				}
                
                myUser.provider?.tasks = [Task]();
                
                for task in loadingTasks {
                    myUser.provider?.tasks.append(task)
                }
                
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}

			//            group.leave()
		}

		DispatchQueue.global().sync {
			super.viewWillAppear(animated)
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (myUser.provider?.tasks.count)!
	}

	let cellIdentifier = "AssignedTaskTableViewCell"
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "AssignedTaskTableViewCell", for: indexPath) as? AssignedTaskTableViewCell  else {
			fatalError("The dequeued cell is not an instance of AssignedTaskTableViewCell.")
		}
        
        if((myUser.provider?.tasks.count)! <= indexPath.row) {
            
            let numberToAdd = indexPath.row + 1 - (myUser.provider?.tasks.count)!
            let sampleTask = Task(requestor : myUser.requestor!)
            
            for i in 0...(numberToAdd) {
                myUser.provider?.tasks.append(sampleTask)
            }
        }

		let task = myUser.provider?.tasks[indexPath.row]

		cell.title.text = task?.title
		cell.fee.text = String(format:"%.2f", (task?.fee)!)
		cell.dateTime.text = String(describing: task!.dateTime)
		cell.location.text = task?.location

		return cell
	}

	@IBAction func unwindToAssignedList(sender: UIStoryboardSegue) {
		if let view = view as? UITableView {
			view.reloadData();
		}
	}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
	// send the task that you clicked on information to the AssignedTaskViewController
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueAssignedTask" {

			let task = myUser.provider?.tasks[((view as! UITableView).indexPathForSelectedRow!.row)]

			// Create an instance of PlayerTableViewController and pass the variable
			let destinationVC = segue.destination as! AssignedTaskViewController
			destinationVC.task = task

		}
	}
}
