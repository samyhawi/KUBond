//
//  MessageController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 16/12/2016.
//  Copyright © 2016 SamyAl-Hawi. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class MessageController: UITableViewController{
    
    var ref: FIRDatabaseReference!

    let cellId = "cellId"
    var users = [UserDatabase]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        
        fetchUser()
      
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UserDatabase(dic: dictionary)
                
                 user.setValuesForKeys(dictionary)
                self.users.append(user)
                

            }
            
        }, withCancel: nil)
        
            }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.detailTextLabel?.text = user.email
        cell.detailTextLabel?.text = user.userCourse
        cell.textLabel?.text = user.userFName
        cell.detailTextLabel?.text = user.userLName
        
        
        return cell
        
    }
    
}


