//
//  ProgressViewController.swift
//  Click
//
//  Created by Sam Dhondt on 17/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let dataManager = DataManager()
    private var progress = Progress()
    private var rudiments = ["Overall"]

    @IBOutlet weak var highestBPMLabel: UILabel!
    @IBOutlet weak var lowestBPMLabel: UILabel!
    @IBOutlet weak var longestSessionLabel: UILabel!
    @IBOutlet weak var lastPracticeLabel: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    
    @IBOutlet weak var rudimentPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress = dataManager.getProgress()
        rudiments.append(contentsOf: progress.getAllRudimentsInProgress())
        
        // setup labels
        highestBPMLabel.text = String(progress.getHighestBPMAchieved())
        lowestBPMLabel.text = String(progress.getLowestBPMAchieved())
        
        let longestSession = progress.getLongestSession()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        longestSessionLabel.text = "\(longestSession.rudimentName) - \(dateFormatter.string(from: longestSession.duration!))"
        dateFormatter.dateFormat = "dd-MM-yyyy"
        lastPracticeLabel.text = dateFormatter.string(from: progress.getLastTimePracticed())
        dateFormatter.dateFormat = "dd:HH:mm:ss"
        timeSpentLabel.text = dateFormatter.string(from: progress.getTotalTimePracticed())
        
        // setup rudimentPickerView
        rudimentPickerView.dataSource = self
        rudimentPickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rudiments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rudiments[row]
    }
    
    
}
