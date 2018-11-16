//
//  APIService.swift
//  Exchange Ability
//
//  Created by Ece Pidik on 2018-10-23.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class APIService {
    
    let url = "http://localhost:8000";
    
    func getUsers(completion: @escaping (_ users: Any) -> ()) {
        var users: Any = {};
        
        let usersUrl = URL(string:(url));
        let task = URLSession.shared.dataTask(with: usersUrl!) {
            (data, response, error) in
                users = try? JSONSerialization.jsonObject(with: data!);
            completion(users)
        }
        task.resume()
    }
    
    func getTasks(completion: @escaping (_ tasks: [[String: Any]]) -> ()) {
        var tasks: [[String: Any]] = [[:]];
        
        let tasksUrl = URL(string:(url + "/tasks"));

        let task = URLSession.shared.dataTask(with: tasksUrl!) {
            (data, response, error) in
            tasks = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]];
//            print(tasks)
            completion(tasks)
        }
        task.resume()
    }

	func getproviderTasks(providerID: Int, completion: @escaping (_ tasks: [[String: Any]]) -> ()) {
		var tasks: [[String: Any]] = [[:]];

		let tasksUrl = URL(string:(url + "/tasks/mytasks/" + String(providerID)));
        print(tasksUrl)

		let task = URLSession.shared.dataTask(with: tasksUrl!) {
			(data, response, error) in
            print(response);
			tasks = try! JSONSerialization.jsonObject(with: data!) as! [[String: Any]];
//            print(tasks)
			completion(tasks)
		}
		task.resume()
	}
    
    //Method just to execute request, assuming the response type is string (and not file)
    func HTTPsendRequest(request: URLRequest,
                         callback: @escaping (Error?, String?) -> Void) {
        print("HERE")
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if (err != nil) {
                callback(err,nil)
            } else {
                callback(nil, String(data: data!, encoding: String.Encoding.utf8))
            }
        }
        task.resume()
    }
    
    // post JSON
    func createTask(task: Task, callback: @escaping (Error?, String?) -> Void) {
        
        
        let addTaskUrl = "http://localhost:8000/add/task";
        var taskData = Dictionary<String, Any>()
        
        taskData["requesterid"] = 1
        taskData["title"] = task.title
        taskData["fee"] = task.fee
        taskData["address"] = task.location
        taskData["description"] = task.description
        taskData["state"] = "open"
        
        let data = try! JSONSerialization.data(withJSONObject: taskData, options: [])
        
        var request = URLRequest(url: URL(string: addTaskUrl)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        request.httpBody = data
        HTTPsendRequest(request: request, callback: callback)
    }
    
    
}
