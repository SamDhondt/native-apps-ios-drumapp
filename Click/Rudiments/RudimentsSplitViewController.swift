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
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        guard let masterNavigationController = primaryViewController as? UINavigationController,
//            let master = masterNavigationController.topViewController as? RudimentsViewController,
//            let detailNavigationController = secondaryViewController as? UINavigationController,
//            let detail = detailNavigationController.topViewController as? RudimentsDetailViewController
//        else { return true }
//
//        detail.rudiment = master.rudiments.first
//
//        return master.detailCollapsed
        return true
    }
}

