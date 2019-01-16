//
//  RudimentsDetailViewController.swift
//  Click
//
//  Created by Sam Dhondt on 04/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import UIKit

class RudimentsDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stickingLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var rudiment: Rudiment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateUI() {
        loadViewIfNeeded()
        nameLabel.text = rudiment?.name
        nameLabel.setNeedsDisplay()
        stickingLabel.text = rudiment?.sticking
        stickingLabel.setNeedsDisplay()
    }

}

extension RudimentsDetailViewController: RudimentSelectionDelegate {
    func onRudimentSelected(_ rudiment: Rudiment) {
        self.rudiment = rudiment
        updateUI()
    }
    
    
}
