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

	@IBOutlet weak var assignTaskButton: UIButton!
	var task: Task?


	override func viewDidLoad() {
        super.viewDidLoad()

		titleLabel.text = task?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		super.prepare(for: segue, sender: sender)

		// Configure the destination view controller only when the save button is pressed.
		guard let button = sender as? UIButton, button === assignTaskButton else {
			os_log("The assign button was not pressed, cancelling", log: OSLog.default, type: .debug)
			return
		}

		task?.provider = myUser.provider
		task?.state = Task.State.assigned
	}

}
