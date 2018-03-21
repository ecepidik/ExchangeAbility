//
//  Provider.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class Provider : UserRole {
	var rating: Int = 0
	var user: User
	
	public var providerRating : ProviderRating?

	init(user: User) {
		self.user = user
	}

	var tasks = [Task]()

}
