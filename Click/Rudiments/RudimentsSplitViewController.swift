//
//  RudimentsSplitViewController.swift
//  Click
//
//  Created by Sam Dhondt on 03/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import UIKit

class RudimentsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    private var collapseDetail = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self

        if (UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.pad) {
            collapseDetail = true
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        return collapseDetail
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
