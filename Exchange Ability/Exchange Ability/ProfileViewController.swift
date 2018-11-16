//
//  ProfileViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-11-16.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	@IBOutlet weak var firstName: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var lastName: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()

		firstName.text = myUser.firstName
		lastName.text = myUser.lastName
		email.text = myUser.email
		phoneNumber.text = myUser.phone
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
