//
//  UserRole.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

protocol UserRole {
	var user: User { get set }
	var rating: Int { get set }
}

extension UserRole {
	var rating : Int {
		return 0
	}
}

