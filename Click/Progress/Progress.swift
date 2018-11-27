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
    var practiceSessions: [PracticeSession] = []
    var practiced: Bool {
        return practiceSessions.count > 0
    }
    
//    func getFavoriteRudimentName() -> String {
//        let rudiments = practiceSessions.map({ $0.rudiment!.name })
//        let rudimentCount = rudiments.reduce(into: [:]) { $0[$1, default: 0] += 1 }
//        return rudimentCount.max(by: { $0.1 < $1.1 } )?.key ?? "No favorite rudiment, go practice some more!"
//    }
    
    func getHighestBPMAchieved(forRudiment rudimentName: String? = nil) -> Int {
        return filterPracticeSessions(onRudiment: rudimentName).max(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLowestBPMAchieved(forRudiment rudimentName: String? = nil) -> Int {
        return filterPracticeSessions(onRudiment: rudimentName).min(by: { $0.tempo < $1.tempo })?.tempo ?? 0
    }
    
    func getLongestSession(forRudiment rudimentName: String? = nil) -> Date? {
        if let ps = filterPracticeSessions(onRudiment: rudimentName).max(by: {$0.duration!.timeIntervalSince1970 < $1.duration!.timeIntervalSince1970}) {
            return ps.duration
        }
        return nil
    }
    
    func getTotalTimePracticed(forRudiment rudimentName: String? = nil) -> Date {
        return Date(timeIntervalSince1970: filterPracticeSessions(onRudiment: rudimentName).map({ $0.duration!.timeIntervalSince1970 }).reduce(0.0, { $0 + $1 }))
    }
    
    func getLastTimePracticed(forRudiment rudimentName: String? = nil) -> Date {
        return Date(timeIntervalSince1970: filterPracticeSessions(onRudiment: rudimentName).map({ $0.start!.timeIntervalSince1970}).min()!)
    }
    
    func getAllRudimentsInProgress() -> [String] {
        return Array(Set(practiceSessions.map({ $0.rudiment!.name })))
    }
    
    private func filterPracticeSessions(onRudiment rudimentName: String?) -> [PracticeSession] {
        if let toFilter = rudimentName {
            return practiceSessions.filter({ $0.rudiment?.name == toFilter })
        }
        return practiceSessions
    }
    
    
}
