//
//  RudimentsDetailViewController.swift
//  Click
//
//  Created by Sam Dhondt on 04/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import UIKit
import RxSwift

/// Presents the detail of a Rudiment showing the name, sticking and comments
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
        commentsTableView.isHidden = true
        if let rud = rudiment {
            progress.startAnimating()
            _ = DrumAPI.retrieveComments(forRudiment: rud).timeout(3, scheduler: MainScheduler.instance).subscribe(
                onNext: { comments in
                    self.progress.stopAnimating()
                    self.commentsTableView.isHidden = false
                    self.comments.removeAll()
                    self.comments.append(contentsOf: comments)
                    self.commentsTableView.reloadData()
                },
                onError: { error in
                    self.progress.stopAnimating()
                    print(error.localizedDescription)
                    self.showErrorAlert()
                }
            )
        }
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Failed to retrieve comments", message: "Check your internet connection and try again", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.retrieveCommentsFromApi()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
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
