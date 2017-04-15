//
//  UsersViewController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 15/04/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseUI


class UsersViewController: UIViewController {
    var friends:[UserDatabase] = [UserDatabase]()
    var users:[UserDatabase] = [UserDatabase]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        fetchUsers()
        fetchFriends()
    }
    
    
    func fetchUsers() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {[weak self] (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print("userssssss \(dictionary)")
                let user = UserDatabase(dic: dictionary)
                // 
                let currentUserEmail = FIRAuth.auth()?.currentUser?.email
                if (user.email != currentUserEmail){
                    self?.users.append(user)
                }
                self?.tableView.reloadData()
            }
            
            }, withCancel: nil)
    }
    
    func fetchFriends(){
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("friends").observe(.childAdded, with: {[weak self] (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UserDatabase(dic: dictionary)
                let currentUserEmail = FIRAuth.auth()?.currentUser?.email
                if (user.email != currentUserEmail){
                    if (self?.doesFriendExist(user: user) == false){
                        self?.friends.append(user)
                    }
                    
                }
                self?.tableView.reloadData()
            }
            }, withCancel: nil)
    }

}

extension UsersViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return friends.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCellIdentifier", for: indexPath) as? UsersTableViewCell
        
        if indexPath.section == 0 {
            if let user = friends[indexPath.row] as? UserDatabase{
                cell?.setUpCell(user: user)
            }
        }else{
            if let user = users[indexPath.row] as? UserDatabase{
                cell?.setUpCell(user: user)
            }
        }
        
        
        return cell!
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        let label = UILabel(frame: headerView.bounds)
        headerView.addSubview(label)
        if section == 0 {
            label.text = "Your Contacts"
        }else{
            label.text = "All Contacts"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // show delete dialog
            if let currentFriend = friends[indexPath.row] as? UserDatabase{
            let alertController = UIAlertController(title: "Delete Friend?", message: "Do you want to delete this user", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { [weak self](alert) in
                // do the firebase call here
               self?.deleteFriend(newFriend: currentFriend)
            })
            
            let cancel = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler:nil)
            alertController.addAction(cancel)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            }
        }else{
            // show add dialog
            
            if let newFriend = users[indexPath.row] as? UserDatabase{
                if !doesFriendExist(user: newFriend) {
                    let messageCopy = "Do you want to add \(newFriend.userFName) \(newFriend.userLName)"
                    let alertController = UIAlertController(title: "Add Friend?", message: messageCopy, preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { [weak self](alert) in
                        // do the firebase call here
                        self?.addFriend(newFriend: newFriend)
                    })
                    
                    let cancel = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler:nil)
                    alertController.addAction(cancel)
                    alertController.addAction(alertAction)
                    present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Already Friends?", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:nil)
                    alertController.addAction(cancel)
                    present(alertController, animated: true, completion: nil)
                }

                
            }
            
        }
        
    }
    
    func doesFriendExist(user:UserDatabase)->Bool{
        let doesFriendExistArray = friends.filter() {$0.email == user.email}
        if doesFriendExistArray.count > 0{
            return true
        }
        return false;
    }
    
    func deleteFriend(newFriend:UserDatabase){
        let farray = friends.filter() {$0.email != newFriend.email}
        friends = farray
        let myDictionary = farray.map{return $0.convertToDictionary()}
        let ref = FIRDatabase.database().reference(fromURL: "https://kubond-e9d06.firebaseio.com/")
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("friends").setValue(myDictionary){ [weak self] (error, frRef) in
            self?.tableView.reloadData()
        }
    }
    
    func addFriend(newFriend:UserDatabase){
        friends.append(newFriend)
        users = users.filter() {$0.email != newFriend.email}
        let myDictionary = friends.map{return $0.convertToDictionary()}
        let ref = FIRDatabase.database().reference(fromURL: "https://kubond-e9d06.firebaseio.com/")
        ref.child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("friends").setValue(myDictionary){ [weak self] (error, frRef) in
            self?.tableView.reloadData()
        }
    }
}
