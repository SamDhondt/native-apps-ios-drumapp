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
    var rudiment: Rudiment! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        rudimentNameLabel.text = rudiment.name
        rudimentStickingLabel.text = rudiment.sticking
    }

}
