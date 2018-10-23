//
//  APIService.swift
//  Exchange Ability
//
//  Created by Ece Pidik on 2018-10-23.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import Foundation

class APIService {
    
    let url = URL(string: "http://localhost:8000");
    
    func getUsers() {

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("The response was:")
           // print (data);
            let users = try? JSONSerialization.jsonObject(with: data!);
            print(users)
        }
        task.resume()
    }
    
    
}
