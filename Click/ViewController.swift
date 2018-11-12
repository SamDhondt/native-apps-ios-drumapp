//
//  ViewController.swift
//  Click
//
//  Created by Sam Dhondt on 05/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        tempoLabel.text = String(newValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

