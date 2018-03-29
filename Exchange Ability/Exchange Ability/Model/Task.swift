//
//  Task.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class Task {
	private static var lastId = 0
	public var id = Task.newId()
	public var title = ""
	public var category = Category.other
	public var description = ""
	public var dateTime = Date()
	public var fee = 0.0
	public var location = "" 	// TODO make into location object
	public var immediateAssign = false
	// TODO images
	public var state: State?
	public var requestor: Requestor
	public var provider: Provider?
	public var requestorRating : RequestorRating?


	init(requestor: Requestor) {
		self.requestor = requestor
	}

	public enum State {
		case opened
		case completed
		case pending
		case assigned
		case cancelled
	}

    public enum Category: String {
		case snowRemoval = "Snow Removal"
		case lawnCare = "Lawn Care"
		case moving = "Moving"
		case furnitureAssembly = "Furniture Assembly"
		case cleaning = "Cleaning"
		case dogWalking = "Dog Walking"
		case delivery = "Delivery"
		case other = "Other"
	}

	private static func newId() -> Int {
		Task.lastId += 1
		return Task.lastId
	}

}
