//
//  RudimentsViewController.swift
//  Click
//
//  Created by Sam Dhondt on 28/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit
import RealmSwift

class RudimentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    private var rudiments = [Rudiment]()
    private var filteredRudiments = [Rudiment]()
    private var notificationToken: NotificationToken?
    private var applyFilter = false

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
        
//        let realm = try! Realm()
//        notificationToken = realm.observe({ notification, realm in
//            self.rudiments.removeAll()
//            self.rudiments.append(contentsOf: realm.objects(Metronome.self))
//        })
        
    }
    
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
            cell.rudimentNameLabel.text = rudiment.name
            cell.rudimentStickingLabel.text = rudiment.sticking
            return cell
        }
        fatalError("Could not create RudimentCell")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            applyFilter = false
        } else {
            applyFilter = true
            filteredRudiments.append(contentsOf: rudiments.filter({
                $0.name.lowercased().contains(searchText.lowercased())
            }))
        }
        rudimentTableView.reloadData()
    }

}
