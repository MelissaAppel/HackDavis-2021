//
//  LoginPageController.swift
//  HackDavis
//
//  Created by Melissa Appel on 1/16/21.
//

import UIKit
import Firebase

class LoginPageController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    //when Login is pressed check firebase for account, if account is found, login and transition to Tab Bar page
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                    self!.errorLabel.text = "Account not found."
                } else {
                    self!.performSegue(withIdentifier: "LoginToTabBar", sender: self)
                }
          
            }
        }
    }
    
  

}
