//
//  RudimentsViewController.swift
//  Click
//
//  Created by Sam Dhondt on 28/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class RudimentsViewController: UIViewController {
    private var rudiments: [Rudiment] = []
    private let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rudiments.append(contentsOf: dataManager.getRudiments())
        
        print(rudiments)
    }

}
