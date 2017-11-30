//
//  ResultCell.swift
//  TwitterPoll
//
//  Created by SimpuMind on 11/29/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import GTProgressBar

class ResultCell: UITableViewCell {

    @IBOutlet weak var progressBar: GTProgressBar!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
