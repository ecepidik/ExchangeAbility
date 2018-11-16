//
//  Task.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-27.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

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
	public var photo: UIImage?
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
		case pendingCompleted		// if provider marks as completed before requestor
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

	func getAllTasks() -> [Task] {
		allTasks = [Task]();

		APIService().getTasks() { tasks in
		for item in tasks {
			// get requestor
			let requestorId : Int = item["requesterid"] as! Int
			let requestor = getUserDatabase(uid: requestorId)
			let requestorUser = requestor.requestor

			let newTask: Task = Task(requestor: requestorUser!);

			let stateString = item["state"] as! String
			switch stateString {
				case "open":
				newTask.state = Task.State.opened
				case "completed":
				newTask.state = Task.State.completed
				case "pendingCompleted":
				newTask.state = Task.State.pendingCompleted
				case "assigned":
				newTask.state = Task.State.assigned
				case "cancelled":
				newTask.state = Task.State.cancelled
				default:
				newTask.state = Task.State.pending
			}
			newTask.title = item["title"] as! String
			newTask.fee = item["fee"] as! Double
			newTask.description = item["description"] as! String
			newTask.location = item["address"] as! String
			// TODO parse date and provider
			//newTask.dateTime = item["date"] as! Date

			//					newTask.provider = (getUserDatabase(uid: (item["providerid"] as? Int)?)).provider

			allTasks.append(newTask)
		//                    print(newTask.id)
		}
		}
		return allTasks
	}
}
