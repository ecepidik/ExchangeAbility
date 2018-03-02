//
//  RequestorRating.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class RequestorRating {
	private var stars = 0
	private var comment: String?
	public var task : Task
	public var requestor: Requestor

	init(task: Task, requestor: Requestor) {
		self.task = task
		self.requestor = requestor
	}


}
