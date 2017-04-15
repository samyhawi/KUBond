//
//  RegisterViewController.swift
//  BondKU
//
//  Created by Al-Hawi, Samy (LDN-MEW) on 31/10/2016.
//  Copyright © 2016 SamyAl-Hawi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var loginEmailTxtField: UITextField!
    @IBOutlet weak var loginPassTxtField: UITextField!
    
    // Hides keyboard when VC is touched.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: Any) {
        
        let loginEmail = loginEmailTxtField.text;
        let loginPass = loginPassTxtField.text;
        
        func displayErrorMessage(userMessage:String){
            
            let myAlert = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil);
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion:nil)
        }
        
        
        //check empty fields
        if ((loginEmail?.isEmpty)! || (loginPass?.isEmpty)!){
            displayErrorMessage(userMessage: "Complete all fields")
            return;
        }
        
        //firebase login authenticator 
        FIRAuth.auth()?.signIn(withEmail: loginEmail!, password: loginPass!, completion: { (user, error) in
            if error != nil{
                print(error!)
                displayErrorMessage(userMessage: "E-Mail or password is incorrect")
                return
            }
            self.dismiss(animated: true, completion: nil);
            
        })
        
    }
}
