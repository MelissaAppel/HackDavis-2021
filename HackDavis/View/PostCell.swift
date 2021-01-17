//
//  PostCell.swift
//  HackDavis
//
//  Created by Haruna Yamakawa on 1/17/21.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
