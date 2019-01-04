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
    
    var rudiment: Rudiment! {
        didSet {
            nameLabel.text = rudiment.name
            stickingLabel.text = rudiment.sticking
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rudiment = Rudiment("Paradiddle", "RLRRLRLL")
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
