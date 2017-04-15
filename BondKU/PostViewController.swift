//
//  PostViewController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 15/04/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class PostViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        // firebase call post
        let postRef = FIRDatabase.database().reference(fromURL: "https://kubond-e9d06.firebaseio.com/posts")
        let email = FIRAuth.auth()?.currentUser?.email
    
        postRef.childByAutoId().setValue([
            "text":textView.text,
            "sender":email,
            ]) { [weak self] (error, frRef) in
                self?.dismiss(animated: true, completion: nil)
        }

    }

}
