//
//  User.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 16/12/2016.
//  Copyright © 2016 SamyAl-Hawi. All rights reserved.
//
import UIKit

class UserDatabase: NSObject {
    
    var userFName: String?
    var userLName: String?
    var email: String?
    var userCourse: String?
    
    init(dic:[String: Any]) {
        userFName = dic["userFName"] as? String ?? ""
        userLName = dic["userLName"] as? String ?? ""
        email = dic["email"] as? String ?? ""
        userCourse = dic["userCourse"] as? String ?? ""
        
    }
    
    func convertToDictionary()-> [String:Any]{
        return ["userFName":userFName!, "userLName":userLName!,"email":email!,"userCourse":userCourse!]
    }
   

}
