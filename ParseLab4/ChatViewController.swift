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
        if let texts = Message["text"] as! String? {
        let texts = textTextField.text
        }
        //my text which a is an object in a class Message in pfobject goes into the textfield
        Message["user"] = PFUser.current()
        Message.saveInBackground { (Bool, error) in
            //this should mean that anyone's messages including mine should be saved
            if let error = error {
                let errorString = error.localizedDescription
                // why does error have to be in a if let statement? because its a parameter and might be nil?
                print("error: \(errorString)")
            } else {
                print("messages can be saved")
            }
        }
        //my message at this point should be saved in background
        
    }
    
    
    func onTimer() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        //messages to be displayed in order
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                print("Successfully retrieved \(objects?.count)")
                //finding objects in background...if error doesn't exist, object is in background
                if let objects = objects {
                    for object in objects {
                        print(object)
                        let text = object["text"] as? String
                        //make the text the value(key) of the object
                        //my messages at this point should be like all the messages saved in the background
                        self.messages.append(text)
                    }
                    //objects might be an optional
                    self.tableView.reloadData()
                    
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath as IndexPath) as! chatCell
        let text =  messages[indexPath.row]
        cell.messagesLabel.text = text
        //lets the text of others be displayed in each cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        //the number of chats are number of cells
    }
}
