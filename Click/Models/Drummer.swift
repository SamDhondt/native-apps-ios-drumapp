//
//  Drummer.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

class Drummer: Object {
    @objc dynamic var name = ""
    @objc dynamic var metronome: Metronome?
    @objc dynamic var progress: Progress?
    @objc dynamic var currentRudiment: Rudiment?
}
