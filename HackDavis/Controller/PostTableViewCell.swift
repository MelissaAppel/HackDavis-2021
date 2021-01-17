//
//  PostTableViewCell.swift
//  HackDavis
//
//  Created by Aryan Vaid on 1/17/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
