//
//  ProgressViewController.swift
//  Click
//
//  Created by Sam Dhondt on 17/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    private let dataManager = DataManager()
    private var progress = Progress()

    override func viewDidLoad() {
        super.viewDidLoad()
        progress = dataManager.getProgress()
    }
    
    
}
