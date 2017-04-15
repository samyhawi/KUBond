//
//  MainTabBarController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 06/03/2017.
//  Copyright © 2017 SamyAl-Hawi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //mainTabToLoginSegue
        checkIfUserIsLoggedIn()
        
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLougout), with: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//                    self.welcomeLbl.text = dictionary["userFName"] as? String
//                }
                
            }, withCancel: nil)
        }
    }
    
    func handleLougout(){
        do{
            try FIRAuth.auth()?.signOut()
        }catch let logoutError{
            print (logoutError)
        }
        performSegue(withIdentifier: "mainTabToLoginSegue", sender: nil)
        
        
    }
}


