//
//  ViewSnapViewController.swift
//  OmrisChat
//
//  Created by Omri Shalev on 20/08/2017.
//  Copyright © 2017 Omri Shalev. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = snap.desc

    }

}
