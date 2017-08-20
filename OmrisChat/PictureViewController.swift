//
//  PictureViewController.swift
//  OmrisChat
//
//  Created by Omri Shalev on 23/07/2017.
//  Copyright © 2017 Omri Shalev. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nextTapped: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextTapped.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload!")
            if error != nil {
                print("We had an error:\(error)")
            }else {
                print(metadata!.downloadURL()!.absoluteString)
                
                self.performSegue(withIdentifier: "selectUser", sender: metadata?.downloadURL()!.absoluteString)
            }
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.desc = descriptionTextField.text!
    }
}
