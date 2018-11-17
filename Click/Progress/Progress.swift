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
    
    func getHighestBPMAchieved(forRudiment rudimentName: String) -> Int {
        return practiceSessions.filter({ $0.rudiment?.name == rudimentName }).max(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLowestBPMAchieved() -> Int {
        return practiceSessions.min(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLowestBPMAchieved(forRudiment rudimentName: String) -> Int {
        return practiceSessions.filter({ $0.rudiment?.name == rudimentName }).min(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLongestSession() -> (rudimentName: String, duration: Date?) {
        if let ps = practiceSessions.max(by: {$0.duration!.timeIntervalSince1970 < $1.duration!.timeIntervalSince1970}) {
            return (ps.rudiment!.name, ps.duration)
        }
        return ("", nil)
    }
    
    func getLongestSession(forRudiment rudimentName: String) -> Date? {
        if let ps = practiceSessions.filter({$0.rudiment?.name == rudimentName}).max(by: {$0.duration!.timeIntervalSince1970 < $1.duration!.timeIntervalSince1970}) {
            return ps.duration
        }
        return nil
    }
    
    func getTotalTimePracticed() -> Date {
        return Date(timeIntervalSince1970: practiceSessions.map({ $0.duration!.timeIntervalSince1970 }).reduce(0.0, { $0 + $1 }))
    }
    
    func getTotalTimePracticed(forRudiment rudimentName: String) -> Date {
        return Date(timeIntervalSince1970: practiceSessions.filter({ $0.rudiment?.name == rudimentName }).map({ $0.duration!.timeIntervalSince1970 }).reduce(0.0, { $0 + $1 }))
    }
    
    func getLastTimePracticed() -> Date {
        return Date(timeIntervalSince1970: practiceSessions.map({ $0.start!.timeIntervalSince1970}).min()!)
    }
    
    func getLastTimePracticed(forRudiment rudimentName: String) -> Date {
        return Date(timeIntervalSince1970: practiceSessions.filter({ $0.rudiment!.name == rudimentName }).map({ $0.start!.timeIntervalSince1970}).min()!)
    }
    
    func getAllRudimentsInProgress() -> [String] {
        return Array(Set(practiceSessions.map({ $0.rudiment!.name })))
    }
    
    
}
