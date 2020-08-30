//
//  ViewController.swift
//  ChatFirebase
//
//  Created by Trung Le on 8/29/20.
//  Copyright © 2020 Trung Le The. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let storybroad = UIStoryboard(name: loginStoryboardName, bundle: nil)
            let vc = storybroad.instantiateViewController(withIdentifier: loginViewControllerIdentifier)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        do {
            try FirebaseAuth.Auth.auth().signOut()

            let storybroad = UIStoryboard(name: loginStoryboardName, bundle: nil)
            let vc = storybroad.instantiateViewController(withIdentifier: loginViewControllerIdentifier)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        catch {
            print("Failed to log out")
        }
    }
}

