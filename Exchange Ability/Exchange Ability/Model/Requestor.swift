//
//  Requestor.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class Requestor : UserRole {
	var user: User
	var rating = 0
	public var requestorRating : RequestorRating?

	init(user: User) {
		self.user = user
	}
}
