//
//  RegisterViewController.swift
//  ChatFirebase
//
//  Created by Trung Le on 8/29/20.
//  Copyright © 2020 Trung Le The. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var intersexButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    private var sex = 1
    private let fisrtName = "Trung"
    private let lastName = "Le"
    
    let radioController: RadioButtonController = RadioButtonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioController.buttonsArray = [maleButton,femaleButton,intersexButton]
        radioController.defaultButton = maleButton
    }
    
    @IBAction func onRegister(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty,
            password.count >= 6 else {
                alertUserLoginError()
                return
        }
        // bật loading
        
        // Firebase Register
        
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                // tắt loading
            }
            
            guard !exists else {
                // user already exists
                strongSelf.alertUserLoginError(message: "Looks like a user account for that email address already exists.")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error cureating user")
                    return
                }
                
                let user = UserManager(firstName: strongSelf.fisrtName , lastName: strongSelf.lastName, emailAddress: email, sex: strongSelf.sex)
                DatabaseManager.shared.insertUser(with: user) { (success) in
                    if success {
                        // upload image
//                        guard let image = strongSelf.imageView.image,
//                            let data = image.pngData() else {
//                                return
//                        }
                        guard let data = UIImage(named: "radio_off")?.pngData() else {
                            return
                        }
                        let filename = user.profilePictureFileName
                        StorageManager.shared.uploadProfilePicture(with: data, fileName: filename, completion: { result in
                            switch result {
                            case .success(let downloadUrl):
                                UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                            case .failure(let error):
                                print("Storage maanger error: \(error)")
                            }
                        })
                    }
                }
                
                 strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                
            })
        })
        
    }
    
    func alertUserLoginError(message: String = "Please enter all information to create a new account.") {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func onMaleButtonAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func onFemaleAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func onIntersexAction(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
}
