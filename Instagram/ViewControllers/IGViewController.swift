//
//  IGViewController.swift
//  Instagram
//
//  Created by MacBookPro9 on 11/3/18.
//  Copyright © 2018 MacBookPro9. All rights reserved.
//

import UIKit

class IGViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionImg: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var chooseImg: UIButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func onSelctImg(_ sender: Any) {
        ImagePickerIns()
    }
    
    @IBAction func onChooseImg(_ sender: Any) {
         performSegue(withIdentifier: "PickSegue", sender: self)
       
    }
    
    func ImagePickerIns (){
        
        let vc = UIImagePickerController()
        vc.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(UIAlertAction) in
           
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                print("Camera is available 📸")
                //vc.sourceType = .camera
                vc.allowsEditing = true
                vc.sourceType = UIImagePickerControllerSourceType.camera
            } else {
                print("Camera 🚫 available so we will use photo library instead")
                let alertController = UIAlertController(title: "Camera 🚫", message: "Camera is unavailable on this emulator device - Let's try Photo Library", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(UIAlertAction)
                
                
            }
            self.present(vc, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library ...", style: .default, handler: {(UIAlertAction) in
            vc.allowsEditing = true
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
       
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        ImageView.contentMode = .scaleToFill
        ImageView.image = originalImage
        ImageView.image = editedImage
        
        picker.dismiss(animated: true, completion: nil)
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
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
