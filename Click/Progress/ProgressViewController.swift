//
//  ProgressViewController.swift
//  Click
//
//  Created by Sam Dhondt on 17/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ProgressViewController: UIViewController, UISearchBarDelegate {
    
    private let dataManager = DataManager()
    private var progress = Progress()
//    private var rudiments = ["Overall"]
    private var selectedRudiment: String?
    private var notificationToken: NotificationToken?
    

    @IBOutlet weak var highestBPMLabel: UILabel!
    @IBOutlet weak var lowestBPMLabel: UILabel!
    @IBOutlet weak var longestSessionLabel: UILabel!
    @IBOutlet weak var lastPracticeLabel: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    
    
    @IBOutlet weak var rudimentSearchBar: UISearchBar!
    
//    @IBOutlet weak var rudimentPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress = dataManager.getProgress()
        
        let realm = try! Realm()
        notificationToken = realm.observe({ [unowned self] note, realm in self.progress = self.dataManager.getProgress()})
//        rudiments.append(contentsOf: progress.getAllRudimentsInProgress())
        rudimentSearchBar.delegate = self
        
        setUpLabels()
    }
    
    @IBAction func resetProgressClicked(_ sender: UIButton) {
        var message = "Are you sure you want to reset all progress?"
        if let rud = selectedRudiment {
            message = "Are you sure you want to reset progress for rudiment \(rud)"
        }
        let confirmationDialog = UIAlertController(title: "Confirm Reset", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            // reset progress
            self.dataManager.resetProgress(of: self.selectedRudiment)
            self.setUpLabels()
        })
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        confirmationDialog.addAction(confirmAction)
        confirmationDialog.addAction(cancelAction)
        
        present(confirmationDialog, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            selectedRudiment = nil
            setUpLabels()
        } else {
            if let index = progress.practiceSessions.index(where: {$0.rudiment!.name.lowercased() == searchText.lowercased()}) {
                selectedRudiment = progress.practiceSessions[index].rudiment!.name
                setUpLabels()
            }
        }
    }

    private func setUpLabels() {
        highestBPMLabel.text = "Highest BPM: \(String(progress.getHighestBPMAchieved(forRudiment: selectedRudiment)))"
        lowestBPMLabel.text = "Lowest BPM: \(String(progress.getLowestBPMAchieved(forRudiment: selectedRudiment)))"
        
        let longestSession = progress.getLongestSession(forRudiment: selectedRudiment)
        longestSessionLabel.text = "Longest session: \(longestSession?.getAsHoursMinutesSecondsString() ?? "No practice sessions")"
        if let lastPractice = progress.getLastTimePracticed(forRudiment: selectedRudiment) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            lastPracticeLabel.text = "Date of last practice: \(dateFormatter.string(from: lastPractice))"
        } else {
            lastPracticeLabel.text = "Date of last practice: No practice sessions"
        }

        timeSpentLabel.text = "Total time spent practicing: \(progress.getTotalTimePracticed(forRudiment: selectedRudiment).getAsDaysHoursMinutesSecondsString())"
        
    }
}

extension Date {
    func getAsHoursMinutesSecondsString() -> String {
        let seconds = Int(self.timeIntervalSince1970)
        return "\(seconds / 3600)h \((seconds % 3600) / 60)m \((seconds % 3600) % 60)s"
    }
    
    func getAsDaysHoursMinutesSecondsString() -> String {
        let seconds = Int(self.timeIntervalSince1970)
        return "\(seconds / (24 * 3600))d \((seconds % (24 * 3600)) / 3600)h \((seconds % 3600) / 60)m \((seconds % 3600) % 60)s"
    }
}
