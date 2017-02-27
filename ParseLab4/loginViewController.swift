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
        PFUser.logInWithUsername(inBackground: "usernameTextField", password: "passwordTextField") {
            (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                print("error w log in")
            } else {
                print("Logged in!");
            }
            
        }
        
       // @IBAction
        func signupButton(_ sender: Any) {
            var user = PFUser()
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackground () {
                (succeeded: Bool?, error: Error?) -> Void in
                if error == nil {
                    let errorString = ["error"]
                    print("error with signup")
                } else {
                    self.performSegue(withIdentifier: "createNewUserAndGoToDashboard", sender: self)
                    print("sucess")
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
    
    
    func loginSegue() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
        self.present(vc, animated: true, completion: nil)
    }
}
