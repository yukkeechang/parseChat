//
//  loginViewController.swift
//  ParseLab4
//
//  Created by Yukkee chang on 2/22/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController  {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                print("error w log in")
                //put the alert here and stop user from logging in
            } else {
                print("Logged in!");
                //todo: perform segue to go to chat view controller
                self.performSegue(withIdentifier: "successLogin", sender: nil)
                
            }
            
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground () {
            (succeeded: Bool?, error: Error?) -> Void in
            if error == nil {
                self.performSegue(withIdentifier: "successLogin", sender: self)
                print("sucess")
            } else {
                let errorString = error?.localizedDescription
                print(errorString)
                
            }
        }
    }
    /*    var currentUser = PFUser.current()
     if currentUser != nil {
     } else {
     // Show the signup or login screen
     //put the error or alert thing here
     } */
}
