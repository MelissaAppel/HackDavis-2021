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
    
<<<<<<< HEAD
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
=======
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

>>>>>>> 29806d7465235038dc49dff721dceaad1db6d2b8
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButtonPressed(_ sender: Any) {
        // send data to database
<<<<<<< HEAD
        var dataDictionary: [String: Any] = [:]
        dataDictionary["description"] = descriptionTextView.text
        dataDictionary["dishName"] = foodTypeTextField.text
        dataDictionary["spice"] = spicyTextField.text
        dataDictionary["type"] = foodTypeTextField.text
        ref.child("posts").childByAutoId().setValue(dataDictionary)
        self.dismiss(animated: true, completion: nil)
    
    }

=======
        let foodName = foodNameTextField.text
        let foodType = foodTypeTextField.text
        let spicy = spicyTextField.text
        let description = descriptionTextView.text
        // add food image
        
        db.collection("posts").addDocument(data: [
            "description" : description,
            "dishName": foodName,
            "spice": spicy,
            "type": foodType
        ]) { (error) in
            if let e = error  {
                print(e)
            } else {
                print("successfully saved")
            }
        }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
>>>>>>> 29806d7465235038dc49dff721dceaad1db6d2b8

}
