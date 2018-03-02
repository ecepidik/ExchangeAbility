//
//  ProviderRating.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class ProviderRating {
	private var stars = 0
	private var comment: String?
	public var task : Task
	public var provider: Provider

	init(task: Task, provider: Provider) {
		self.task = task
		self.provider = provider
	}

}
