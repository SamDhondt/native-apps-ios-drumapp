//
//  Drummer.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation

struct Drummer {
    let name: String
    let metronome: Metronome
    let progress = Progress()
    var currentRudiment: Rudiment?
}
