//
//  RequestorViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-10-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit
import MessageUI

class RequestorViewController: UIViewController, MFMessageComposeViewControllerDelegate {
	@IBOutlet weak var requestorName: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!

	let number = "5555555555"	// used as fake phone number until we can get it from the database
	var requestor: Requestor?

	override func viewDidLoad() {
        super.viewDidLoad()

		requestorName.text = requestor?.user.firstName
		email.text = requestor?.user.email
		phoneNumber.text = requestor?.user.phone

		// TODO get total average rating for this user
    }
    
	@IBAction func contactRequestor(_ sender: Any) {
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
