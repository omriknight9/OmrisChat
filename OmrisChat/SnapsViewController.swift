//
//  SnapsViewController.swift
//  OmrisChat
//
//  Created by Omri Shalev on 23/07/2017.
//  Copyright © 2017 Omri Shalev. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var snaps: [Snap] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let snap = Snap()
            let snapshotDic = snapshot.value as? NSDictionary
            snap.imageURL = snapshotDic!["imageURL"] as! String
            snap.from = snapshotDic!["from"] as! String
            snap.desc = snapshotDic!["description"] as! String
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
            
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }

    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
