//
//  RudimentCell.swift
//  Click
//
//  Created by Sam Dhondt on 30/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class RudimentCell: UITableViewCell {

    @IBOutlet weak var rudimentNameLabel: UILabel!
    @IBOutlet weak var rudimentStickingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
