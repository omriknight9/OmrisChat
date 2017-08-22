//
//  ViewSnapViewController.swift
//  OmrisChat
//
//  Created by Omri Shalev on 20/08/2017.
//  Copyright © 2017 Omri Shalev. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = snap.desc
        imageview.sd_setImage(with: URL(string: snap.imageURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("Deleted the pic")
        }
    }

}
