//
//  MyUser.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-20.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

// create tempopary user profile
var myUser : User = {
	var newUser = User()
	newUser.uid = UIDevice.current.identifierForVendor!.uuidString
	newUser.provider = Provider(user : newUser)
	newUser.requestor = Requestor(user : newUser)
	allUsers.append(newUser)
	return newUser;
}()


