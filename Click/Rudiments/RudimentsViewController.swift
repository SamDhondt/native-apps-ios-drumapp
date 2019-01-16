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

    var rudimentSelectionDelegate: RudimentSelectionDelegate?


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
        
        guard let rightNav = splitViewController?.viewControllers.last as? UINavigationController,
            let detail = rightNav.topViewController as? RudimentsDetailViewController
        else { fatalError("Could not find DetailViewController") }
        
        rudimentSelectionDelegate = detail
        detail.rudiment = rudiments.first
        
//        let realm = try! Realm()
//        notificationToken = realm.observe({ notification, realm in
//            self.rudiments.removeAll()
//            self.rudiments.append(contentsOf: realm.objects(Metronome.self))
//        })
        
    }
    
}

// MARK: TableView
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rudimentSelected = rudiments[indexPath.row]
        rudimentSelectionDelegate?.onRudimentSelected(rudimentSelected)
        detailCollapsed = false
        if let detailViewController = rudimentSelectionDelegate as? RudimentsDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
}

// MARK: UISearchBar
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

protocol RudimentSelectionDelegate: class {
    func onRudimentSelected(_ rudiment: Rudiment)
}
