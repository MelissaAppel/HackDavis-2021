//
//  DetailPostViewController.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit
import SDWebImage

class DetailPostViewController: UIViewController {
    var dishName = ""
    var imageURL = ""
    var flavor = ""
    var type = ""
    var descriptionText = ""
    
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        dishNameLabel.text = dishName
        flavorLabel.text = flavor
        typeLabel.text = type
        descriptionLabel.text = descriptionText
        let url = URL(string: imageURL)
        dishImageView.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions.highPriority,context: nil, progress: nil, completed: nil)

    }
}
