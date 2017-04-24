
//  HomepageViewController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 06/12/2016.
//  Copyright © 2016 SamyAl-Hawi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseUI

class HomepageViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var postButton: UIBarButtonItem!
    let cellId = "cellId"
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        fetchPosts()
        title = "WELCOME USER"
        navigationController?.navigationBar.barTintColor = .blue
        let cancelButton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutAction(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let barButton = UIBarButtonItem(title: "POST", style: .plain, target: self, action: #selector(postAction))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func postAction(){
        performSegue(withIdentifier: "postListToPostSegue", sender: nil)
    }
    
    func fetchPosts() {
        FIRDatabase.database().reference().child("posts").observe(.childAdded, with: {[weak self] (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print("\(dictionary)")
                let post = Post(dic: dictionary)
                self?.posts.append(post)
                self?.tableView.reloadData()
            }
            
        }, withCancel: nil)
        
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logOutAction(_ sender: Any) {
        // logout
        if let mainTab = tabBarController as? MainTabBarController{
            mainTab.handleLougout()
        }
        
    }
}

extension HomepageViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCellIdentifier", for: indexPath) as? PostsTableViewCell
        if let post = posts[indexPath.row] as? Post{
            cell?.setUpCell(post: post)
        }
        return cell!
        
    }

}
