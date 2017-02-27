//
//  ChatViewController.swift
//  ParseLab4
//
//  Created by Yukkee chang on 2/23/17.
//  Copyright © 2017 Yukkee chang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var textTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [String?]()
    //an array of strings that might be empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self , selector: #selector(onTimer), userInfo: nil, repeats: true)
    }
    
    
    
    
    @IBAction func sendMessage(_ sender: Any) {
      let Message = PFObject(className:"Message")
        
       Message["text"] = textTextField.text
        //this should mean that my text which a is message in pfobject goes into the textfield
       Message["user"] = PFUser.current()
        
        Message.saveInBackground { (Bool, error) in
            //this should mean that anyone's messages including mine should be saved
            
            
            if let error = error {
                let errorString = error.localizedDescription
                //basically let errorString == to wahtever the error is
                print("error")
                print(errorString)
            } else {
                print("messages can be saved")
            }
        }
        
    }
    
    
    func onTimer() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                print("Successfully retrieved \(objects?.count)")
                //what's the point of this again..it doesn't print the above message but it prints messages from other people..so this works!
                if let objects = objects {
                    for object in objects {
                        print(object)
                        let text = object["text"] as? String
                        self.messages.append(text)
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath as IndexPath) as! chatCell
       let text =  messages[indexPath.row]
       cell.messagesLabel.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        //the number of chats are number of cells
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
