//
//  Database.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-03-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

var allUsers : [User] = []
var allTasks : [Task] = {
	var sampleTasks = [Task]()
	var task = Task(requestor : myUser.requestor!)
	task.title = "Snow shovel"
	task.category = Task.Category.snowRemoval
	task.fee = 10.0
	task.description = "I have a large driveway I want shoveled"
	task.dateTime = Date()
	task.location = "3514 rue Hutchison"
	//	TODO: add image
	task.state = Task.State.opened
	sampleTasks.append(task)
	return sampleTasks;
}()

