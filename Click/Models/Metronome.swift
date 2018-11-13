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
    var soundType: SoundType {
        get { return SoundType(rawValue: soundTypeRaw)! }
        set { soundTypeRaw = newValue.rawValue }
    }
    @objc dynamic var playing = false
    private var interval: Timer?
    
    func play() {
        playing = true
        print("metronome is playing")
    }
    
    func stop() {
        playing = false
        print("metronome has stopped")
    }
    
    private func click() {
        print(soundType)
    }
}

enum SoundType: String, CaseIterable {
    case Click, Snare, Kick, HiHat
}
