//
//  User.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class User {
	public var uid = ""
	public var email = ""
	public var firstName = ""
	public var lastName = ""
	public var phone = ""
	public var password = ""
	public var provider : Provider?
	public var requestor : Requestor?

}

func getUserDatabase(uid : Int) -> User{
	var newUser = User()
	newUser.uid = String(uid)
	APIService().getUserInfo(userID: uid) { user in
		for item in user {
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
}
