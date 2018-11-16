//
//  MyUser.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-20.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

var userID = 2;

// create tempopary user profile
var myUser : User = {
	var newUser = User()
	APIService().getUserInfo(userID: userID) { user in
		for item in user {
			newUser.uid = String(userID)
			newUser.firstName = item["firstname"] as! String
			newUser.lastName = item["lastname"] as! String
			newUser.email = item["email"] as! String
			newUser.phone = item["phone"] as! String
		}
	}

//	var newUser = User()
//	newUser.uid = UIDevice.current.identifierForVendor!.uuidString
	newUser.provider = Provider(user : newUser)
	newUser.requestor = Requestor(user : newUser)
	allUsers.append(newUser)
	return newUser;


}()


