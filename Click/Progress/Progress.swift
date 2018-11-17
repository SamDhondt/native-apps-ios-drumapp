//
//  Progress.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

class Progress: Object {
    var practiceSessions: List<PracticeSession> = List()
    var practiced: Bool {
        return practiceSessions.count > 0
    }
    
    func getFavoriteRudimentName() -> String {
        let rudiments = practiceSessions.map({ $0.rudiment!.name })
        let rudimentCount = rudiments.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        return rudimentCount.max(by: { $0.1 < $1.1 } )?.key ?? "No favorite rudiment, go practice some more!"
    }
    
    func getHighestBPMAchieved() -> Int {
        return practiceSessions.max(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLowestBPMAchieved() -> Int {
        return practiceSessions.min(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLongestSession() -> (rudimentName: String, duration: Date) {
        if let ps = practiceSessions.max(by: {$0.duration!.timeIntervalSince1970 < $1.duration!.timeIntervalSince1970}) {
            return (ps.rudiment!.name, ps.duration!)
        }
        return ("", Date())
    }
    
    func getTotalTimePracticed() -> Date {
        return Date(timeIntervalSince1970: practiceSessions.map({ $0.duration!.timeIntervalSince1970 }).reduce(0.0, { $0 + $1 }))
    }
    
    
}
