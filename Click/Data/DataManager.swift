//
//  DataManager.swift
//  Click
//
//  Created by Sam Dhondt on 13/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    private(set) var realm: Realm
    private(set) var metronome: Metronome
    
    init() {
        realm = try! Realm()
        if let metronome = realm.objects(Metronome.self).first {
            self.metronome = metronome
        } else {
            metronome = Metronome()
            try! realm.write {
                realm.add(metronome)
            }
        }
    }
    
}
