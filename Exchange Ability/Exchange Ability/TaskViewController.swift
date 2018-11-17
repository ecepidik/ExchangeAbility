//
//  TaskViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-28.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit
import os.log


class TaskViewController: 
UIViewController {
	//MARK: Properties
	@IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var compensationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var categoryValue: UILabel!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var compensationValue: UILabel!
    @IBOutlet weak var locationValue: UILabel!
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var requestor: UIButton!
	@IBOutlet weak var requestorLink: UIButton!
	@IBOutlet weak var decriptionText: UITextView!
	
	var task: Task?

	override func viewDidLoad() {
        super.viewDidLoad()
        
		titleValue.text = task?.title
        categoryValue.text = task?.category.rawValue

		//TODO fix time
//        dateValue.text = String(describing: (task?.dateTime)!)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE, MMM d @ h:mm a"
		let date = dateFormatter.string(from: ((task?.dateTime)!))
		dateValue.text = date

        compensationValue.text = "$" + String(format: "%.2f", (task?.fee)!)
        locationValue.text = task?.location
        decriptionText.text = task?.description
		if task?.photo != nil {
			image = UIImageView(image: task?.photo)
		}
		requestorLink.setTitle(task?.requestor.user.firstName, for: .normal)

        // Do any additional setup after loading the view.
    }

//	@IBAction func goToRequestorProfile(_ sender: Any) {
//		// TODO send the task data over
//		let requestor = task?.requestor
//
//		// open the Requestor profile page
////		let requestorViewContr = RequestorViewController(nibName: "RequestorViewController", bundle: nil)
//		let requestorViewContr = self.storyboard?.instantiateViewController(withIdentifier: "RequestorViewController")
////		requestorViewContr.requestor = requestor
//		self.navigationController?.pushViewController(requestorViewContr!, animated: true)
//
//	}

	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// when you click do this task button
	@IBAction func assignTask(_ sender: Any) {
		let alert = UIAlertController(title: "You will now be assigned to complete this task", message: "Be sure to complete the task at the assigned time, contact your poster for any questions", preferredStyle: .alert)

		// if the user says yes, unassign the task
		let yesAction = UIAlertAction(title: "Confirm", style: .default) { (action) -> Void in
			// TODO: unassign task
			// update task state back to opened
			self.task?.state = Task.State.opened

			// assigned the task to the current user and updates the state
			self.task?.provider = myUser.provider
			self.task?.state = Task.State.assigned
			// go back to the previous feed page
			self.performSegue(withIdentifier: "unwindToTaskList", sender: self)
		}

		alert.addAction(yesAction)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		self.present(alert, animated: true)

//		// assigned the task to the current user and updates the state
//		task?.provider = myUser.provider
//		task?.state = Task.State.assigned
//		// go back to the previous feed page
//		performSegue(withIdentifier: "unwindToTaskList", sender: self)
	}

    // MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//		super.prepare(for: segue, sender: sender)
//
//		// Configure the destination view controller only when the save button is pressed.
//		guard let button = sender as? UIButton, button === assignTaskButton else {
//			os_log("The assign button was not pressed, cancelling", log: OSLog.default, type: .debug)
//			return
//		}

		// when pressing on the requestors name, bring to requestor page
		if segue.destination is RequestorViewController
		{
			// pass the requestor info over
			let vc = segue.destination as? RequestorViewController
			vc?.requestor = task?.requestor
		}

	}

	

}
