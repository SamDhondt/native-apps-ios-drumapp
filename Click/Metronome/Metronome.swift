//
//  Metronome.swift
//  Click
//
//  Created by Sam Dhondt on 06/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

/// Represents a metronome which can be played and of which the tempo and sound can be set. Classes and structs that implement the OnClickListener protocol can listen to this metronome to handle the ticking.
class Metronome: Object {
    @objc dynamic var tempo = 60
    
    // backing field used to persist soundType
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
    
    /// Starts playing the metronome by setting a scheduledTimer that calls the private method tick() at intervals. tick() lets the onTickListener know when the metronome ticks. Sets playing to true.
    func play() {
        playing = true
        tick()
        interval = Timer.scheduledTimer(
                timeInterval: 60.0 / Double(tempo),
                target: self,
                selector: #selector(tick),
                userInfo: nil, repeats: true)
    }
    
    /// Stops the metronome by invalidating the interval timer. Sets playing to false.
    func stop() {
        playing = false
        interval?.invalidate()
    }
    
    /// Convenience method which resets the metronome if it is playing by calling stop() followed by start()
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

/// Enum declaring the different sound types the metronome can be set to
enum SoundType: String, CaseIterable {
    case Click, Snare, Kick, Clap
}
