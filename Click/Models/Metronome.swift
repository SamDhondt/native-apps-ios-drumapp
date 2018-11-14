//
//  Metronome.swift
//  Click
//
//  Created by Sam Dhondt on 06/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift
import AudioToolbox

class Metronome: Object {
    @objc dynamic var tempo = 60
    
    @objc private dynamic var soundTypeRaw: String = SoundType.Click.rawValue
    
    // is persisted by soundTypeRaw
    var soundType: SoundType {
        get { return SoundType(rawValue: soundTypeRaw)! }
        set {
            soundTypeRaw = newValue.rawValue
            if playing { stop(); play() }
        }
    }
    
    // unnecessary for persistence
    var playing = false
    private var interval: Timer?
    var soundURL: URL?
    
    func play() {
        playing = true
        if let URL = Bundle.main.url(
            forResource: "\(soundType.rawValue)",
            withExtension: "m4a",
            subdirectory: "Sounds") {
            soundURL = URL
            tick()
            interval = Timer.scheduledTimer(
                timeInterval: 60 / Double(tempo),
                target: self,
                selector: #selector(tick),
                userInfo: nil, repeats: true)
        }
        
    }
    
    func stop() {
        playing = false
        interval?.invalidate()
    }
    
    func reset() {
        if playing {
            stop()
            play()
        }
    }
    
    @objc private func tick() {
        // source: https://stackoverflow.com/questions/24043904/creating-and-playing-a-sound-in-swift#25048225
        // plays a sound using a sound file
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL! as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        
        print(soundType.rawValue)
    }
}

enum SoundType: String, CaseIterable {
    case Click, Snare, Kick, Clap
}
