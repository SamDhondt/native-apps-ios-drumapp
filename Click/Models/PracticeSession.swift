//
//  PracticeSession.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation

struct PracticeSession {
    let start: Date
    var end: Date?
    let rudiment: Rudiment
    
    init(startTime start: Date, forRudiment rudiment: Rudiment){
        self.start = start
        self.rudiment = rudiment
    }
}
