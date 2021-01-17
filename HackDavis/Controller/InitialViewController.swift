//
//  LoginViewControl.swift
//  evolv
//
//  Created by Aryan Vaid on 1/1/21.
//  Copyright © 2021 Evolv Ideas. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "logIn") == true {
            print("User logged in ")
            let userId = UserDefaults.standard.string(forKey: "currentUserID")!
            MyDatabase.shared.setCurrentUserID(currentUserID: userId)
           self.performSegue(withIdentifier: "loggedIn", sender: nil)
        }else{
            print("User not Logged in ")
            self.performSegue(withIdentifier: "notLoggedIn", sender: nil)
        }
    }
}
