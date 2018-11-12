//
//  Metronome.swift
//  Click
//
//  Created by Sam Dhondt on 06/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation

struct Metronome {
    var tempo = 60
    var sound = SoundType.Click
    private(set) var playing = false
    private var interval: Timer?
    
    mutating func play() {
        playing = true
        print("metronome is playing")
    }
    
     mutating func stop() {
        playing = false
        print("metronome has stopped")
    }
    
    private func click() {
        print(sound)
    }
}

enum SoundType: String {
    case Click, Snare, Kick, HiHat
}
