//
//  PracticeSession.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

class PracticeSession: Object {
    @objc dynamic var start: Date?
    @objc dynamic var end: Date?
    @objc dynamic var rudiment: Rudiment?
    @objc dynamic var progress: Progress?
    
    convenience init(forRudiment rudiment: Rudiment){
        self.init()
        start = Date()
        self.rudiment = rudiment
    }
    
    convenience init(startTime start: Date, endTime end: Date, forRudiment rudiment: Rudiment, drummerProgress progress: Progress){
        self.init()
        self.start = start
        self.end = end
        self.rudiment = rudiment
        self.progress = progress
    }
}