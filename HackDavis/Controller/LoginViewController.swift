//
//  LoginViewController.swift
//  HackDavis
//
//  Created by Aryan Vaid on 1/17/21.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseDatabase
import FirebaseFirestore

class LoginViewController: UIViewController, FUIAuthDelegate {
    
    var authUI : FUIAuth?
    var ref : DatabaseReference?
    var fstore: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize the firebase UI
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        fstore = Firestore.firestore()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers : [FUIAuthProvider] = [FUIGoogleAuth()]
        authUI?.providers = providers
        if Auth.auth().currentUser != nil {
            let userID = (Auth.auth().currentUser?.uid)!
            UserDefaults.standard.set(true, forKey: "logIn")
            UserDefaults.standard.set(userID, forKey: "currentUserID")
            MyDatabase.shared.setCurrentUserID(currentUserID: userID)
        }else{
            MyDatabase.shared.setCurrentUserID(currentUserID: "")
        }
    }

    @IBAction func buttonPressed(_ sender: Any) {
        print("Start button pressed")
        if Auth.auth().currentUser == nil {
            if let authVC = authUI?.authViewController() {
                authVC.modalPresentationStyle = .fullScreen
                    present(authVC, animated: true, completion: nil)
                }
           }else {
                do {
                    try Auth.auth().signOut()
                }
                catch {}
            }
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            //Log the error
            print(error!)
            return
        }
        print("signed in??")
        let userID = (Auth.auth().currentUser?.uid)!
        UserDefaults.standard.set(true, forKey: "logIn")
        UserDefaults.standard.set(userID, forKey: "currentUserID")
        MyDatabase.shared.setCurrentUserID(currentUserID: userID)
        //Segue to the next screen
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
        
        func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
                return true
        }
      // other URL handling goes here.
      return false
    }
  }
}

