//
//  CommentCell.swift
//  Click
//
//  Created by Sam Dhondt on 04/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var comment: Comment? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        authorLabel.text = comment?.author
        messageLabel.text = comment?.message
    }

}
