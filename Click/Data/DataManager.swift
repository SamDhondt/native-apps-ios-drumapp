//
//  DataManager.swift
//  Click
//
//  Created by Sam Dhondt on 13/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class DataManager {
    private(set) var realm: Realm
    
    init() {
        // start with new DB
        // comment this out to keep working with same DB
        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        realm = try! Realm()
        initDB()
    }
    
    private func initDB() {
        let rudiments: [Rudiment] = [
            Rudiment(rudimentName: "Paradiddle", sticking: "RLRRLRLL"),
            Rudiment(rudimentName: "Single Stroke Roll", sticking: "RLRLRLRL"),
            Rudiment(rudimentName: "Double Stroke Roll", sticking: "RRLLRRLL")
        ]
        
        let drummerProgress = Progress()
        
        let practiceSessions: [PracticeSession] = [
            PracticeSession(startTime: Date(), endTime: Date().addingTimeInterval(120), forRudiment: rudiments[0], 80, drummerProgress: drummerProgress),
            PracticeSession(startTime: Date(), endTime: Date().addingTimeInterval(240), forRudiment: rudiments[0], 120, drummerProgress: drummerProgress),
            PracticeSession(startTime: Date(), endTime: Date().addingTimeInterval(60), forRudiment: rudiments[0], 60, drummerProgress: drummerProgress)
        ]
        
        
        try! realm.write {
            realm.add(Metronome())
            realm.add(rudiments)
            realm.add(drummerProgress)
            realm.add(practiceSessions)
        }
        
        drummerProgress.practiceSessions.append(objectsIn: realm.objects(PracticeSession.self).filter({$0.progress == drummerProgress}))
    }
    
    func getMetronome() -> Metronome {
        return realm.objects(Metronome.self).first!
    }
    
    func getProgress() -> Progress {
        return realm.objects(Progress.self).first!
    }
}
