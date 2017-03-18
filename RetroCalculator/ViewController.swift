//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Felix Kramer on 18/3/17.
//  Copyright © 2017 Felix Kramer. All rights reserved.
//

import UIKit
//import AVFoundation to work with sounds
import AVFoundation


class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        
        //NOTE - FOR ANYTHING THAT HAS A 'THROWS' IT MEANS IT CAN THROW AN ERROR SO YOU NEED TO DO A 'DO - CATCH' STATEMENT SO IT DOESN't CRASH THE APP. I.e. if this were to fail, it would leave the do block and go straight into the catch block
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            //Just print the error to the console so we can see what happened
            print(err.debugDescription)
        }
    }

    //You can create this IBAction in the view controller when it is empty, and then using the assistant editor drag the little plus on the left hand side (e.g. next to line 35 in this case) to all the buttons so that they can all call that action
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        //just in case someone is pressing the sound really fast to cancel it really fast
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }

}

