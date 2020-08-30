//
//  LoginViewController.swift
//  ChatFirebase
//
//  Created by Trung Le on 8/29/20.
//  Copyright © 2020 Trung Le The. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func onSingin(_ sender: Any) {
        
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let storybroad = UIStoryboard(name: registerStoryboardName, bundle: nil)
        let vc = storybroad.instantiateViewController(withIdentifier: registerViewControllerIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
