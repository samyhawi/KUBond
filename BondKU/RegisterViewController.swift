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


class RegisterViewController: UIViewController {


    @IBOutlet weak var userFNameTxtField: UITextField!
    
    @IBOutlet weak var userLNameTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var courseTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var confirmPasswordTxtField: UITextField!

    
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
    
    @IBAction func createAccountButton(_ sender: Any) {
        
        let userFName = userFNameTxtField.text;
        let userLName = userLNameTxtField.text;
        let userEmail = emailTxtField.text;
        let userCourse = courseTxtField.text;
        let userPass = passwordTxtField.text;
        let confirmUserPass = confirmPasswordTxtField.text;
        
        
        func displayErrorMessage(userMessage:String){
            
            let myAlert = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil);
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion:nil)
        }
        
        // Checks empty fields
        if ((userFName?.isEmpty)! || (userLName?.isEmpty)! ||  (userEmail?.isEmpty)! || (userCourse?.isEmpty)! || (userPass?.isEmpty)! || (confirmUserPass?.isEmpty)!) {
            
            
            //Display error message
            displayErrorMessage(userMessage: "Complete all fields.")
            return;
        }
        
        if (userPass != confirmUserPass){
            //Display errpr message
            displayErrorMessage(userMessage: "Passwords do not match.")
            return;
        }
        if userEmail?.hasSuffix("@kingston.ac.uk") == false {
            displayErrorMessage(userMessage: "Not a valid Kingston University email address.")
            return;
        }
        

        
        
        // Store Data
        
        FIRAuth.auth()?.createUser(withEmail: userEmail!, password: userPass!, completion: { (user: FIRUser?, err) in
            if err != nil{
                print(err!)
                return
            }
            
            //successfully auth user
    
            
            guard let uid = user?.uid else{
                return
            }
            let ref = FIRDatabase.database().reference(fromURL: "https://kubond-e9d06.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["userFName": userFName, "userLName" :userLName, "email" : userEmail, "userCourse" : userCourse]
            usersReference.updateChildValues(values, withCompletionBlock: { (erro, ref) in
                
                if erro != nil{
                    print(erro!)
                    return
                }
                
                self.dismiss(animated: true, completion:nil)
                
                
             
            })

            
        })
        

        
        
    }

    
    
    
    
    /*
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
