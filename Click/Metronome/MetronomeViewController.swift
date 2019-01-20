//
//  MetronomeViewController.swift
//  Click
//
//  Created by Sam Dhondt on 05/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit
import AudioToolbox
import RealmSwift
import Realm

/// Displays controls to use a metronome. Implements OnTickListener so it can listen to a metronome and play sound when it ticks.
class MetronomeViewController: UIViewController, OnTickListener {
    private let realm = try! Realm()
    private lazy var metronome: Metronome? = {
        return realm.objects(Metronome.self).first
    }()
    
    private var timer: Timer?
    private var originalMetronomeTempo = 0
    
    // dictionary that contains the SoundTypes and their corresponding SystemSoundIDs
    private var sounds: [SoundType:SystemSoundID] = [:]
    
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var tempoSlider: UISlider!
    
    @IBOutlet weak var soundControl: UISegmentedControl!
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        try! realm.write {
            metronome?.tempo = newValue
        }
        tempoLabel.text = String(newValue)
    }
    
    @IBAction func onPlayPressed(_ sender: UIButton) {
        if (metronome!.playing){ // Should stop
            metronome!.stop()
            timer?.invalidate()
            playButton.setTitle("Play", for: UIControl.State.normal)
        } else { // Should Play
            metronome!.play()
            originalMetronomeTempo = metronome!.tempo

            // checks every 2 sec if metronome should reset due to tempo change
            // eases more into the new tempo than resetting during onSliderChanged
            timer = Timer.scheduledTimer(
                timeInterval: 0.2,
                target: self,
                selector: #selector(shouldReset),
                userInfo: nil, repeats: true)
            playButton.setTitle("Stop", for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func onSegmentOptionSelected(_ sender: UISegmentedControl) {
        if let option = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            if let newSoundType = SoundType(rawValue: option) {
                try! realm.write {
                    metronome!.soundType = newSoundType
                    metronome!.reset()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! realm.write {
            if (metronome == nil) {
                realm.add(Metronome())
                metronome = realm.objects(Metronome.self).first
            }
            
            metronome!.onTickListener = self
        }
        
        // setup tempoLabel
        tempoLabel.text = String(metronome!.tempo)
        
        // setup tempoSlider
        tempoSlider.value = Float(metronome!.tempo)
        
        
        for index in 0..<SoundType.allCases.count {
            // setup soundControl (Segmented Control)
            let soundType = SoundType.allCases[index]
            soundControl.setTitle(soundType.rawValue, forSegmentAt: index)
            if soundType == metronome!.soundType {
                soundControl.selectedSegmentIndex = index
            }
            
            // setup audioservices
            // SOURCE: https://stackoverflow.com/questions/24043904/creating-and-playing-a-sound-in-swift#25048225
            // for: Creating and playing a sound in Swift
            if let soundURL = Bundle.main.url(
                forResource: "Sounds/\(soundType.rawValue)",
                withExtension: "m4a"){ // attempts to find soundfile
                var soundID: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
                sounds[soundType] = soundID // stores soundID together with soundtype in dictionary for easy retrieval
            }
        }
    }
    
    /// checks if the metronome should be reset when a tempo change occurs
    @objc private func shouldReset(){
        if originalMetronomeTempo != metronome!.tempo {
            originalMetronomeTempo = metronome!.tempo
            metronome!.reset()
        }
    }
    
    func onTick() {
        AudioServicesPlaySystemSound(sounds[metronome!.soundType]!)
    }


}

