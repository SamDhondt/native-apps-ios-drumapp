//
//  Comment.swift
//  Click
//
//  Created by Sam Dhondt on 03/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import Foundation

class Comment {
    var author: String = ""
    var message: String = ""
    
    init(_ author: String, _ message: String) {
        self.author = author
        self.message = message
    }
}
