//
//  RudimentsViewController.swift
//  Click
//
//  Created by Sam Dhondt on 28/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit
import RealmSwift

class RudimentsViewController: UIViewController {
    private(set) var rudiments = [Rudiment]()
    private var filteredRudiments = [Rudiment]()
    private var applyFilter = false
    
    private var notificationToken: NotificationToken?
    
    var detailCollapsed = true

    @IBOutlet weak var rudimentTableView: UITableView!
    @IBOutlet weak var rudimentSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rudiments.append(contentsOf: [
            Rudiment("Paradiddle", "RLRRLRLL"),
            Rudiment("Single Stroke Roll", "RLRLRLRL"),
            Rudiment("Double Stroke Roll", "RRLLRRLL"),
            Rudiment("Paradiddlediddle", "RLRRLL"),
            Rudiment("Six Stroke Roll", "RLLRRL"),
            Rudiment("Double paradiddle", "RLRLRRLRLRLL"),
        ])
        
        rudimentTableView.delegate = self
        rudimentTableView.dataSource = self
        
        rudimentSearchBar.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let detailNav = segue.destination as? UINavigationController,
                let detail = detailNav.topViewController as? RudimentsDetailViewController
                else { fatalError("Could not find detail controller") }
            detail.rudiment = rudiments[rudimentTableView.indexPathForSelectedRow!.row]
        }
    }
    
}

// MARK: Rudiments TableView
extension RudimentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (applyFilter) {
            return filteredRudiments.count
        }
        return rudiments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = rudimentTableView.dequeueReusableCell(withIdentifier: "RudimentCell", for: indexPath) as? RudimentCell {
            let rudiment = applyFilter ? filteredRudiments[indexPath.row] : rudiments[indexPath.row]
            cell.rudiment = rudiment
            return cell
        }
        fatalError("Could not create RudimentCell")
    }
}

// MARK: SearchBar
extension RudimentsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            applyFilter = false
        } else {
            applyFilter = true
            filteredRudiments = rudiments.filter({
                $0.name.lowercased().contains(searchText.lowercased())
            })
        }
        rudimentTableView.reloadData()
    }
}
