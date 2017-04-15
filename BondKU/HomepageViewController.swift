
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
        //  let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCellIdentifier", for: indexPath) as? PostsTableViewCell
        if let post = posts[indexPath.row] as? Post{
            cell?.setUpCell(post: post)
        }
        return cell!
        
    }

}



/*
 import UIKit
 import Firebase
 import FirebaseDatabaseUI
 import FirebaseAuthUI
 
 @objc(PostViewController)
 class PostViewController: UIViewController, UITableViewDelegate {
 
 
 
 // [START define_database_reference]
 var ref: FIRDatabaseReference!
 // [END define_database_reference]
 
 var dataSource: FUITableViewDataSource
 
 @IBOutlet weak var tableView: UITableView!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 // [START create_database_reference]
 ref = FIRDatabase.database().reference()
 // [END create_database_reference]
 
 dataSource = FirebaseTableViewDataSource.init(query: getQuery(),
 modelClass: Post.self,
 nibNamed: "PostTableViewCell",
 cellReuseIdentifier: "post",
 view: self.tableView)
 
 dataSource.populateCell() {
 guard let cell = $0 as? PostTableViewCell else {
 return
 }
 guard let post = $1 as? Post else {
 return
 }
 cell.authorImage.image = UIImage.init(named: "ic_account_circle")
 cell.authorLabel.text = post.author
 var imageName = "ic_star_border"
 if (post.stars?[self.getUid()]) != nil {
 imageName = "ic_star"
 }
 cell.starButton.setImage(UIImage.init(named: imageName), for: .normal)
 if let starCount = post.starCount {
 cell.numStarsLabel.text = "\(starCount)"
 }
 cell.postTitle.text = post.title
 cell.postBody.text = post.body
 }
 
 tableView.dataSource = dataSource
 tableView.delegate = self
 }
 
 override func viewWillAppear(_ animated: Bool) {
 self.tableView.reloadData()
 }
 
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 performSegue(withIdentifier: "detail", sender: indexPath)
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return 150
 }
 
 func getUid() -> String {
 return (FIRAuth.auth()?.currentUser?.uid)!
 }
 
 func getQuery() -> FIRDatabaseQuery {
 return self.ref
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 guard let path: IndexPath = sender as? IndexPath else { return }
 guard let detail: PostDetailTableViewController = segue.destination as? PostDetailTableViewController else {
 return
 }
 let source = self.dataSource
 guard let snapshot: FIRDataSnapshot = (source.object(at: UInt((path as NSIndexPath).row)))! as? FIRDataSnapshot else {
 return
 }
 detail.postKey = snapshot.key
 }
 
 override func viewWillDisappear(_ animated: Bool) {
 getQuery().removeAllObservers()
 }
 
 }*/
