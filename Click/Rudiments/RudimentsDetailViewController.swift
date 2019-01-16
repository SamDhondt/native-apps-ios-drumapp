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
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<5 {
            comments.append(Comment("testAuthor", "This is a test message"))
        }
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
    }
    
    private func updateUI() {
        loadViewIfNeeded()
        nameLabel.text = rudiment?.name
        stickingLabel.text = rudiment?.sticking
        
    }

}

// Mark: SelectionDelegate
extension RudimentsDetailViewController: RudimentSelectionDelegate {
    func onRudimentSelected(_ rudiment: Rudiment) {
        self.rudiment = rudiment
        updateUI()
    }
}

// Mark: TableView
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
