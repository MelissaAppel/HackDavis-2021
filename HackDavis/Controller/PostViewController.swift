//
//  PostViewController.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodTypeTextField: UITextField!
    @IBOutlet weak var spicyTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
