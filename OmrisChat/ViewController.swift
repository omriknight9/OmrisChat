//
//  ViewController.swift
//  OmrisChat
//
//  Created by Omri Shalev on 23/07/2017.
//  Copyright © 2017 Omri Shalev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("Did not connect to Firebase \(error)")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("There was an error: \(error)")
                    } else {
                        print("Created user successfully!")
                        self.performSegue(withIdentifier: "goToChat", sender: nil)
                    }
                })
                
            }else {
                print("You are signed in!")
                self.performSegue(withIdentifier: "goToChat", sender: nil)
            }
            
            
        }
    }
}

