//
//  ViewController.swift
//  Click
//
//  Created by Sam Dhondt on 05/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, OnTickListener {
    private let dataManager = DataManager()
    private var timer: Timer?
    private var originalMetronomeTempo = 0
    private var sounds: [SoundType:SystemSoundID] = [:]
    
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
            timer?.invalidate()
            playButton.setTitle("Play", for: UIControl.State.normal)
        } else {
            dataManager.metronome.play()
            originalMetronomeTempo = dataManager.metronome.tempo
            timer = Timer.scheduledTimer(
                timeInterval: 2,
                target: self,
                selector: #selector(shouldReset),
                userInfo: nil, repeats: true)
            playButton.setTitle("Stop", for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func onSegmentOptionSelected(_ sender: UISegmentedControl) {
        if let option = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            if let newSoundType = SoundType(rawValue: option) {
                try! dataManager.realm.write {
                    dataManager.metronome.soundType = newSoundType
                    dataManager.metronome.reset()
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! dataManager.realm.write {
            dataManager.metronome.onTickListener = self
        }
        
        // setup tempoLabel
        tempoLabel.text = String(dataManager.metronome.tempo)
        
        // setup tempoSlider
        tempoSlider.value = Float(dataManager.metronome.tempo)
        
        
        for index in 0..<SoundType.allCases.count {
            // setup soundControl (Segmented Control)
            let soundType = SoundType.allCases[index]
            soundControl.setTitle(soundType.rawValue, forSegmentAt: index)
            if soundType == dataManager.metronome.soundType {
                soundControl.selectedSegmentIndex = index
            }
            
            // setup audioservices
            // source: https://stackoverflow.com/questions/24043904/creating-and-playing-a-sound-in-swift#25048225
            // plays a sound using a sound file
            if let soundURL = Bundle.main.url(
                forResource: "Sounds/\(soundType.rawValue)",
                withExtension: "m4a"){ // attempts to find soundfile
                var soundID: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
                sounds[soundType] = soundID // stores soundID together with soundtype in dictionary for easy retrieval
            }
        }
    }
    
    @objc private func shouldReset(){
        if originalMetronomeTempo != dataManager.metronome.tempo {
            originalMetronomeTempo = dataManager.metronome.tempo
            dataManager.metronome.reset()
        }
    }
    
    func onTick() {
    AudioServicesPlaySystemSound(sounds[dataManager.metronome.soundType]!)
    }


}

