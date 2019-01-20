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
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    var rudiment: Rudiment?
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        // hides excess empty rows
        commentsTableView.tableFooterView = UIView(frame: CGRect.zero)
        commentsTableView.backgroundColor = UIColor.clear
        
        updateUI()
    }
    
    private func updateUI() {
        nameLabel.text = rudiment?.name
        stickingLabel.text = rudiment?.sticking
        retrieveCommentsFromApi()
    }
    
    private func retrieveCommentsFromApi() {
        progress.startAnimating()
        commentsTableView.isHidden = true
        if let rud = rudiment {
            _ = DrumAPI.retrieveComments(forRudiment: rud).subscribe(onNext: { comments in
                self.progress.stopAnimating()
                self.commentsTableView.isHidden = false
                self.comments.removeAll()
                self.comments.append(contentsOf: comments)
                self.commentsTableView.reloadData()
            })
        }
    }

}

extension RudimentsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.isEmpty ? 1 : comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell {
            
            if (comments.isEmpty) {
                cell.messageLabel.text = "No comments yet."
                cell.authorLabel.text = ""
            } else {
                cell.comment = comments[indexPath.row]
            }
            return cell
        } else {
            fatalError("Could not create CommentCell")
        }
    }
}
