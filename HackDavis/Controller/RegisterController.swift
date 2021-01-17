//
//  RegisterController.swift
//  HackDavis
//
//  Created by Melissa Appel on 1/16/21.
//

import UIKit
import Firebase

class RegisterController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        errorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    //Register email and password with firebase, when registered segue to tab bar page
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                if let e = error {
                    let errorMsg = e.localizedDescription
                    errorLabel.text = "\(errorMsg)"
                } else {
                    self.performSegue(withIdentifier: "RegisterToTabBar", sender: self)
                }
            }
        }
    }
    

}
