//
//  TaskViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-28.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

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
    
    
	var task: Task?


	override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        let date = dateFormatter.string(from: (task?.dateTime)!)
        
		titleValue.text = task?.title
        categoryValue.text = task?.category.rawValue
        dateValue.text = date
        compensationValue.text = String(format: "%.2f", (task?.fee)!)
        locationValue.text = task?.location
        descriptionValue.text = task?.description
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
