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
        set {
            soundTypeRaw = newValue.rawValue
            if playing { stop(); play() }
        }
    }
    
    // unnecessary for persistence
    private(set) var playing = false
    private var interval: Timer?
    var onTickListener: OnTickListener? = nil
    
    
    func play() {
        playing = true
        tick()
        interval = Timer.scheduledTimer(
                timeInterval: 60 / Double(tempo),
                target: self,
                selector: #selector(tick),
                userInfo: nil, repeats: true)
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
        onTickListener?.onTick()
    }
}

enum SoundType: String, CaseIterable {
    case Click, Snare, Kick, Clap
}
