//
//  RequestorViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-10-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class RequestorViewController: UIViewController {
	@IBOutlet weak var requestorName: UILabel!

	var requestor: Requestor?

	override func viewDidLoad() {
        super.viewDidLoad()

		requestorName.text = requestor?.user.firstName

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
