//
//  RudimentsDetailViewController.swift
//  Click
//
//  Created by Sam Dhondt on 04/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import UIKit
import RxSwift

class RudimentsDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stickingLabel: UILabel!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var rudiment: Rudiment?
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        updateUI()
    }
    
    private func updateUI() {
        loadViewIfNeeded()
        nameLabel.text = rudiment?.name
        stickingLabel.text = rudiment?.sticking
    }

}

extension RudimentsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell {
            cell.comment = comments[indexPath.row]
            return cell
        } else {
            fatalError("Could not create CommentCell")
        }
    }
}
