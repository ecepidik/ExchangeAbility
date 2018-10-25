//
//  AssignedTaskViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-10-24.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class AssignedTaskViewController: UIViewController {

	@IBOutlet weak var titleValue: UILabel!
	@IBOutlet weak var categoryValue: UILabel!
	@IBOutlet weak var dateValue: UILabel!
	@IBOutlet weak var compensationValue: UILabel!
	@IBOutlet weak var locationValue: UILabel!
	@IBOutlet weak var descriptionValue: UILabel!

	var task: Task?

	override func viewDidLoad() {
        super.viewDidLoad()

		titleValue.text = task?.title
		categoryValue.text = task?.category.rawValue
		dateValue.text = String(describing: task?.dateTime)
		compensationValue.text = String(format: "%.2f", (task?.fee)!)
		locationValue.text = task?.location
		descriptionValue.text = task?.description

        // Do any additional setup after loading the view.
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
