//
//  PostViewController.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodTypeTextField: UITextField!
    @IBOutlet weak var spicyTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButtonPressed(_ sender: Any) {
        // send data to database
        var dataDictionary: [String: Any] = [:]
        dataDictionary["description"] = descriptionTextView.text
        dataDictionary["dishName"] = foodTypeTextField.text
        dataDictionary["spice"] = spicyTextField.text
        dataDictionary["type"] = foodTypeTextField.text
        ref.child("posts").childByAutoId().setValue(dataDictionary)
        self.dismiss(animated: true, completion: nil)
    
    }


}
