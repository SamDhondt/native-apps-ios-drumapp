//
//  Metronome.swift
//  Click
//
//  Created by Sam Dhondt on 06/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

class Metronome: Object {
    @objc dynamic var tempo = 60
    @objc private dynamic var soundTypeRaw: String = SoundType.Click.rawValue
    
    // is persisted by soundTypeRaw
    var soundType: SoundType {
        get { return SoundType(rawValue: soundTypeRaw)! }
        set { soundTypeRaw = newValue.rawValue }
    }
    
    // unnecessary for persistence
    var playing = false
    private var interval: Timer?
    
    func play() {
        playing = true
        print("metronome is playing")
        interval = Timer.scheduledTimer(
            timeInterval: 60 / Double(tempo),
            target: self,
            selector: #selector(tick),
            userInfo: nil, repeats: true)
    }
    
    func stop() {
        playing = false
        interval?.invalidate()
        print("metronome has stopped")
    }
    
    @objc private func tick() {
        print(soundType.rawValue)
    }
}

enum SoundType: String, CaseIterable {
    case Click, Snare, Kick, HiHat
}
