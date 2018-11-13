//
//  ViewController.swift
//  Click
//
//  Created by Sam Dhondt on 05/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let dataManager = DataManager()
    
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var tempoSlider: UISlider!
    
    @IBOutlet weak var soundControl: UISegmentedControl!
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        try! dataManager.realm.write {
            dataManager.metronome.tempo = newValue
        }
        tempoLabel.text = String(newValue)
    }
    
    @IBAction func onPlayPressed(_ sender: UIButton) {
        if (dataManager.metronome.playing){
            dataManager.metronome.stop()
            playButton.setTitle("Play", for: UIControl.State.normal)
        } else {
            dataManager.metronome.play()
            playButton.setTitle("Stop", for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func onSegmentOptionSelected(_ sender: UISegmentedControl) {
        if let option = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            if let newSoundType = SoundType(rawValue: option) {
                try! dataManager.realm.write {
                    dataManager.metronome.soundType = newSoundType
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tempoLabel
        tempoLabel.text = String(dataManager.metronome.tempo)
        
        // setup tempoSlider
        tempoSlider.value = Float(dataManager.metronome.tempo)
        
        // setup soundControl (Segmented Control)
        var index = 0
        SoundType.allCases.forEach {
            soundControl.setTitle($0.rawValue, forSegmentAt: index)
            if $0 == dataManager.metronome.soundType {
                soundControl.selectedSegmentIndex = index
            }
            index += 1
        }
    }


}

