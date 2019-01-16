//
//  RudimentsSplitViewController.swift
//  Click
//
//  Created by Sam Dhondt on 03/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import UIKit

class RudimentsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let navigationController = primaryViewController as? UINavigationController,
            let master = navigationController.topViewController as? RudimentsViewController
        else { return true }
        
        return master.detailCollapsed
    }
}

