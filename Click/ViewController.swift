//
//  ViewController.swift
//  Click
//
//  Created by Sam Dhondt on 05/11/2018.
//  Copyright © 2018 Sam Dhondt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var metronome = Metronome()
    
    @IBOutlet weak var tempoLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        let newValue = Int(sender.value)
        metronome.tempo = newValue
        tempoLabel.text = String(newValue)
    }
    
    @IBAction func onPlayPressed(_ sender: UIButton) {
        if (metronome.playing){
            metronome.stop()
            playButton.setTitle("Play", for: UIControl.State.normal)
        } else {
            metronome.play()
            playButton.setTitle("Stop", for: UIControl.State.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

