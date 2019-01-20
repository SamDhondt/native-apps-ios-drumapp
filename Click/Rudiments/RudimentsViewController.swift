//
//  RudimentsViewController.swift
//  Click
//
//  Created by Sam Dhondt on 28/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class RudimentsViewController: UIViewController {
    private(set) var rudiments = [Rudiment]()
    private var filteredRudiments = [Rudiment]()
    private var applyFilter = false
    
    private var notificationToken: NotificationToken?
    
    var detailCollapsed = true

    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var rudimentTableView: UITableView!
    @IBOutlet weak var rudimentSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rudimentTableView.delegate = self
        rudimentTableView.dataSource = self
        
        rudimentSearchBar.delegate = self
        
        // MARK: observe Realm
        let realm = try! Realm()
        notificationToken = realm.observe({ notification, realm in
            self.rudiments.removeAll()
            self.rudiments.append(contentsOf: realm.objects(Rudiment.self))
            self.rudimentTableView.reloadData()
        })
        
        // MARK: API Call
        retrieveRudimentsFromApi()
  
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let detailNav = segue.destination as? UINavigationController,
                let detail = detailNav.topViewController as? RudimentsDetailViewController
                else { fatalError("Could not find detail controller") }
            detail.rudiment = rudiments[rudimentTableView.indexPathForSelectedRow!.row]
        }
    }
    
    private func retrieveRudimentsFromApi() {
        let realm = try! Realm()
        
        _ = DrumAPI.retrieveRudiments().subscribe(onNext: { rudiments in
            self.progress.stopAnimating()
            try! realm.write {
                realm.delete(realm.objects(Rudiment.self))
                realm.add(rudiments)
            }
        })
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
