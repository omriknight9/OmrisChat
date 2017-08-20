//
//  SelectUserViewController.swift
//  OmrisChat
//
//  Created by Omri Shalev on 19/08/2017.
//  Copyright © 2017 Omri Shalev. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    var imageURL = ""
    var desc = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let user = User()
            let snapshotDic = snapshot.value as? NSDictionary
            user.email = snapshotDic!["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
        
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from":user.email, "description": desc, "imageURL": imageURL]
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController?.popToRootViewController(animated: true)
    }

}






