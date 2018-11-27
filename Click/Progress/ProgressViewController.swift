//
//  ProgressViewController.swift
//  Click
//
//  Created by Sam Dhondt on 17/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UISearchBarDelegate {
    
    private let dataManager = DataManager()
    private var progress = Progress()
    private var rudiments = ["Overall"]
    private var selectedRudiment: String?
    

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
        rudiments.append(contentsOf: progress.getAllRudimentsInProgress())
        rudimentSearchBar.delegate = self
        
        setUpLabels()
        // setup rudimentPickerView
//        rudimentPickerView.dataSource = self
//        rudimentPickerView.delegate = self
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
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return rudiments.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return rudiments[row]
//    }
    private func setUpLabels(){
        highestBPMLabel.text = "Highest BPM: \(String(progress.getHighestBPMAchieved(forRudiment: selectedRudiment)))"
        lowestBPMLabel.text = "Lowest BPM: \(String(progress.getLowestBPMAchieved(forRudiment: selectedRudiment)))"
        
        let longestSession = progress.getLongestSession(forRudiment: selectedRudiment)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        longestSessionLabel.text = "Longest session: \(dateFormatter.string(from: longestSession!))"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        lastPracticeLabel.text = "Date of last practice: \(dateFormatter.string(from: progress.getLastTimePracticed(forRudiment: selectedRudiment)))"
        dateFormatter.dateFormat = "dd:HH:mm:ss"
        timeSpentLabel.text = "Total time spent practicing: \(dateFormatter.string(from: progress.getTotalTimePracticed(forRudiment: selectedRudiment)))"
    }
}
