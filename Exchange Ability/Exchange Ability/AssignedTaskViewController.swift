//
//  AssignedTaskViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-10-24.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit
import MessageUI

class AssignedTaskViewController: UIViewController, MFMessageComposeViewControllerDelegate {

	@IBOutlet weak var titleValue: UILabel!
	@IBOutlet weak var categoryValue: UILabel!
	@IBOutlet weak var dateValue: UILabel!
	@IBOutlet weak var compensationValue: UILabel!
	@IBOutlet weak var locationValue: UILabel!
	@IBOutlet weak var descriptionValue: UILabel!
	@IBOutlet weak var requestorLink: UIButton!

	var task: Task?
	let number = "5555555555"	// used as fake phone number until we can get it from the database

	override func viewDidLoad() {
        super.viewDidLoad()

		titleValue.text = task?.title
		categoryValue.text = task?.category.rawValue
		dateValue.text = String(describing: (task?.dateTime)!)
		compensationValue.text = String(format: "%.2f", (task?.fee)!)
		locationValue.text = task?.location
		descriptionValue.text = task?.description
		requestorLink.setTitle(task?.requestor.user.firstName, for: .normal)

        // Do any additional setup after loading the view.
    }

	@IBAction func completeTask(_ sender: Any) {
		// check if it is before Date and time of the task
		if (task?.dateTime)! < Date() {
			// if it is then alert to ask if you are sure
			let alert = UIAlertController(title: "Are you sure you completed this task?", message: "It is before the scheduled task time.", preferredStyle: .alert)

			let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
				pendingTask()

				// bring back to My Tasks page
				let assignedTasksView = self.storyboard?.instantiateViewController(withIdentifier: "AssignedTableViewController")
				self.navigationController?.pushViewController(assignedTasksView!, animated: true)

				// TODO: refresh My Tasks page
			}
			alert.addAction(yesAction)
			alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
			self.present(alert, animated: true)
		}

		func pendingTask() {
			// mark task state as pendingCompleted
			task?.state = Task.State.pendingCompleted

			// TODO: send message to requestor to confirm it was completed
		}


	}

	@IBAction func unassignTask(_ sender: Any) {
		// create alert to confirm
		let alert = UIAlertController(title: "Are you sure you want to cancel this task?", message: "Canceling a task after it's assigned to you will lower your raiting.", preferredStyle: .alert)

		// if the user says yes, unassign the task
		let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
			// TODO: unassign task
			// update task state back to opened
			self.task?.state = Task.State.opened

			// TODO: lower user's rating

			// bring back to My Tasks page
			let assignedTasksView = self.storyboard?.instantiateViewController(withIdentifier: "AssignedTableViewController")
			self.navigationController?.pushViewController(assignedTasksView!, animated: true)
		}

		alert.addAction(yesAction)
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
		self.present(alert, animated: true)
	}

	@IBAction func contactPoster(_ sender: Any) {
		// create alert to confirm
		let alert = UIAlertController(title: number, message: nil, preferredStyle: .alert)
		
		let callAction = UIAlertAction(title: "Call", style: .default) { (action) -> Void in
			// call poster
			let url = URL(string: "tel://\(self.number)")
			if UIApplication.shared.canOpenURL(url!) {
				UIApplication.shared.open(url!)
			}
		}

		// message poster
		let textAction = UIAlertAction(title: "Message", style: .default) { (action) -> Void in
			if (MFMessageComposeViewController.canSendText()) {
				let controller = MFMessageComposeViewController()
				controller.body = "Message Body"
				controller.recipients = [self.number]
				controller.messageComposeDelegate = self
				self.present(controller, animated: true, completion: nil)
			}
		}


		alert.addTextField(configurationHandler: { textField in
			textField.placeholder = "Input message here..."
		})
		alert.addAction(textAction)
		alert.addAction(callAction)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		self.present(alert, animated: true)
	}

	// SMS message controller
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
		//... handle sms screen actions
		self.dismiss(animated: true, completion: nil)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
