//
//  ContactsViewController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 27/01/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ContactsViewController: UITableViewController{
    
    let cellId = "cellId"
    var users = [UserDatabase]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        
        fetchUser()
        
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let user = UserDatabase(dic: dictionary)
                
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
                self.users.append(user)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                
                
                //                user.name = dictionary["name"]
            }
        }, withCancel: nil)
    }
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.userFName
        cell.detailTextLabel?.text = user.email
        
        return cell
        
    }
    
}


