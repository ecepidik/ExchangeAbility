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
    
    func getTasks() {
        let usersUrl = URL(string:(url+"/tasks"));
        let task = URLSession.shared.dataTask(with: usersUrl!) {(data, response, error) in
            let tasks = try? JSONSerialization.jsonObject(with: data!);
            print(tasks)
        }
        task.resume()
    }
    
    
}
