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
    @IBOutlet weak var descriptionValue: UILabel!
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var requestor: UIButton!
	@IBOutlet weak var assignTaskButton: UIButton!

	var task: Task?

	override func viewDidLoad() {
        super.viewDidLoad()
        
		titleValue.text = task?.title
        categoryValue.text = task?.category.rawValue
        dateValue.text = String(describing: (task?.dateTime)!)
        compensationValue.text = String(format: "%.2f", (task?.fee)!)
        locationValue.text = task?.location
        descriptionValue.text = task?.description
		if task?.photo != nil {
			image = UIImageView(image: task?.photo)
		}

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
		// assigned the task to the current user and updates the state
		task?.provider = myUser.provider
		task?.state = Task.State.assigned
		// go back to the previous feed page
		performSegue(withIdentifier: "unwindToTaskList", sender: self)
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
