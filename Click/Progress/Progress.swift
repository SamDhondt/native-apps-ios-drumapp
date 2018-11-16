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
}
