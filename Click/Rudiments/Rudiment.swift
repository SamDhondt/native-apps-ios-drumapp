//
//  Rudiment.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation
import RealmSwift

class Rudiment: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var sticking: String = ""
    
    convenience init(_ name: String, _ sticking: String){
        self.init()
        self.name = name
        self.sticking = sticking
    }
}
