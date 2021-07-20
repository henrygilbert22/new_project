//
//  user.swift
//  fitnessApp
//
//  Created by Henry Gilbert on 7/19/21.
//

import UIKit
import Firebase


class user: NSObject {
    
    var username: String?
    var password: String?
    var weight: String?
    var height: String?
    var gender: String?
    
    override
    init()

    {
        
    }
    
    init(username: String, password: String, weight: String, height: String, gender: String)
    {
        self.username = username;
        self.password = password;
        self.weight = weight;
        self.height = height;
        self.gender = gender;
    }
    
    func toAnyObject() -> Any {
      return [
        "username": self.username!,
        "password": self.password!,
        "weight": self.weight!,
        "height": self.height!,
        "gender": self.gender!
      ]
    }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let newUsername = value["username"] as? String,
        let newPassword = value["password"] as? String,
        let newHeight = value["height"] as? String,
        let newWeight = value["weight"] as? String,
        let newGender = value["gender"] as? String
        else {
        return nil
      }
      
    
      self.password = newPassword
      self.username = newUsername
      self.weight = newWeight
      self.height = newHeight
      self.gender = newGender
    }
    

}
