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
//        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        realm = try! Realm()
        
        initDB()
    }
    
    private func initDB() {
        try! realm.write {
            realm.deleteAll()
        }
        
        let rudiments = [
            Rudiment("Paradiddle", "RLRRLRLL"),
            Rudiment("Single Stroke Roll", "RLRLRLRL"),
            Rudiment("Double Stroke Roll", "RRLLRRLL"),
            Rudiment("Paradiddlediddle", "RLRRLL"),
            Rudiment("Six Stroke Roll", "RLLRRL"),
            Rudiment("Double paradiddle", "RLRLRRLRLRLL"),
        ]
        
        let drummerProgress = Progress()
        
        let practiceSessions = [
            PracticeSession(startTime: Date(), endTime: Date().addingTimeInterval(120), forRudiment: rudiments[0], 80, drummerProgress: drummerProgress),
            PracticeSession(startTime: Date().addingTimeInterval(130), endTime: Date().addingTimeInterval(240), forRudiment: rudiments[1], 120, drummerProgress: drummerProgress),
            PracticeSession(startTime: Date().addingTimeInterval(250), endTime: Date().addingTimeInterval(500), forRudiment: rudiments[2], 60, drummerProgress: drummerProgress)
        ]
        
        drummerProgress.practiceSessions.append(contentsOf: practiceSessions)
        
        
        try! realm.write {
            realm.add(Metronome())
            realm.add(rudiments)
            realm.add(drummerProgress)
            realm.add(practiceSessions)
        }
        
    }
    
    func getMetronome() -> Metronome {
        return realm.objects(Metronome.self).first!
    }
    
    func getProgress() -> Progress {
        let progress = realm.objects(Progress.self).first!
        progress.practiceSessions.append(contentsOf: realm.objects(PracticeSession.self))
        return progress
    }
    
    func getRudiments() -> Results<Rudiment> {
        return realm.objects(Rudiment.self)
    }
    
    func resetProgress(of rudimentName: String? = nil) {
        var sessionsToDelete = [PracticeSession]()
        sessionsToDelete.append(contentsOf: rudimentName == nil ? getProgress().practiceSessions : getProgress().practiceSessions.filter({ $0.rudiment!.name == rudimentName }))
        try! realm.write {
            realm.delete(sessionsToDelete)
        }
    }
}
