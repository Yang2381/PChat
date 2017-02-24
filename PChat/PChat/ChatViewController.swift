//
//  ViewController.swift
//  PChat
//
//  Created by YangSzu Kai on 2017/2/23.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textLabel: UITextField!
    var messages :[PFObject]?
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        //Fetch data every 1 seconds by calling the function onTimer
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /************************************************
     Send user sent message to the server.
     User will send username (key "user")
     User will send text (key "text")
     By calling the method saveInBackground
    *************************************************/
    @IBAction func sendText(_ sender: Any) {
        let message = PFObject(className:"Message1234")
        
        message["user"] = PFUser.current()?.username
        message["text"] = textLabel.text
              message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                // The object has been saved.
                self.textLabel.text = nil
                //self.view.window?.endEditing(true)
            } else {
                // There was a problem, check error.description
            }
        }

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! textCell
        
        let textMessage = messages![indexPath.row]
        let userName = textMessage["user"]
        let text = textMessage["text"]
        cell.userNameLabel.text = "\(userName!):" as String?
        cell.messageLabel?.text = text as! String?
        return cell
    }
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages{
            return messages.count
        }else
        {
            return 0
        }
    }
    
    /******************************************************************************
     The function below is fetching chatting history in a time interval of 1 second
     It is using the method findObjectsInBackground to fetch data and store it in 
     messages as PFObject
     It is then set it as the global array messages
    *******************************************************************************/
    func onTimer() {
        let query = PFQuery(className:"Message1234")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground {
            (messages: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                for message in messages!{
                    print(message["text"])
                }
                //Save the fetch object to global messages
                if let messages = messages {
                    self.messages = messages
                    
                    
                }
            } else {
                // Log details of the failure
                print(error)
            }
        }
        self.tableView.reloadData()
    }

}

