//
//  ProfileViewController.swift
//  Firebase-Demo
//
//  Created by Edward O'Neill on 3/2/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNameTextField.delegate = self
        
        updateUI()
    }
    
    private func updateUI() {
        guard let user = Auth.auth().currentUser else { return }
        
        emailLabel.text = user.email
        displayNameTextField.text = user.displayName
        //        user.displayName
        //        user.email
        //        user.phoneNumber
        //        user.photoURL
        
    }
    
    @IBAction func updateProfileButtonPressed(_ sender: UIButton) {
        // change the user's display name
        
        guard let displayName = displayNameTextField.text else {
            print("missing fields")
            return
        }
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        
        request?.displayName = displayName
        request?.commitChanges(completion: { [unowned self] (error) in
            if let error = error {
                // show alert
                self.showAlert(title: "Error", message: "Error changing profile: \(error)")
            } else {
                self.showAlert(title: "Success", message: "Your profile has been successfully updated")
            }
        })
    }
    
    @IBAction func editProfilePhotoButtonPressed(_ sender: UIButton) {
        let alerController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: nil)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alerController.addAction(cameraAction)
        }
        alerController.addAction(photoLibraryAction)
        alerController.addAction(cancelAction)
        present(alerController, animated: true)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
