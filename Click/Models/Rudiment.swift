//
//  Rudiment.swift
//  Click
//
//  Created by Sam Dhondt on 07/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import Foundation

struct Rudiment {
    let name: String
    let sticking: Sticking
    
    init(rudimentName name: String, sticking: Sticking){
        self.name = name
        self.sticking = sticking
    }
    
}
