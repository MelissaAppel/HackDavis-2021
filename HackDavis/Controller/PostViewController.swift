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
    @IBOutlet weak var foodTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var spicySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var descriptionLabel: UITextField!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    
    var ref: DatabaseReference! = Database.database().reference()
    var foodType: String?
    var spice: String?
    var id = 3
    
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
        dataDictionary["description"] = descriptionLabel.text
        dataDictionary["dishName"] = foodNameTextField.text
        dataDictionary["flavor"] = spice
        dataDictionary["type"] = foodType
        dataDictionary["latitude"] = 5.0 as! Double
        dataDictionary["longitude"] = 4.0 as! Double
        // just an example
        dataDictionary["image"] = "https://firebasestorage.googleapis.com/v0/b/hack-davis-f5888.appspot.com/o/Cauliflower%20Tacos.jpg?alt=media&token=6339f58f-4561-428b-b49d-be44c06f16f4"
        ref.child("Database").child("posts").child(String(id)).setValue(dataDictionary)
      
        self.dismiss(animated: true, completion: nil)
    
    }

    @IBAction func foodTypeValueChanged(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            foodType = "Veg"
        } else if sender.selectedSegmentIndex == 1 {
            foodType = "Non-veg"
        } else {
            foodType = "vegan"
        }
    }
    @IBAction func spicyValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            spice = "sweet"
        } else if sender.selectedSegmentIndex == 1 {
            spice = "normal"
        } else {
            spice = "spicy"
        }
    }
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
     
    }
       
    
}

