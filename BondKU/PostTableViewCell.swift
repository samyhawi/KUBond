//
//  PostTableViewCell.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 07/03/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//
import UIKit
import Firebase

@objc(PostTableViewCell)
class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var numStarsLabel: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UITextView!
    var postKey: String?
    var postRef: FIRDatabaseReference!
    
    @IBAction func didTapStarButton(_ sender: AnyObject) {
        if let postKey = postKey {
            postRef = FIRDatabase.database().reference().child("posts").child(postKey)
            incrementStars(forRef: postRef)
            postRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let uid = value?["uid"] as? String {
                    let userPostRef = FIRDatabase.database().reference()
                        .child("user-posts")
                        .child(uid)
                        .child(postKey)
                    self.incrementStars(forRef: userPostRef)
                }
            })
        }
    }
    
    func incrementStars(forRef ref: FIRDatabaseReference) {
        // [START post_stars_transaction]
        ref.runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
                var stars: Dictionary<String, Bool>
                stars = post["stars"] as? [String : Bool] ?? [:]
                var starCount = post["starCount"] as? Int ?? 0
                if let _ = stars[uid] {
                    // Unstar the post and remove self from stars
                    starCount -= 1
                    stars.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    starCount += 1
                    stars[uid] = true
                }
                post["starCount"] = starCount as AnyObject?
                post["stars"] = stars as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return FIRTransactionResult.success(withValue: currentData)
            }
            return FIRTransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        // [END post_stars_transaction]
    }
}
