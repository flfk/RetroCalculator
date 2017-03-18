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
    
    @IBOutlet weak var outputLbl: UILabel!

    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var runningNumber = ""
    
    //initialise it to be empty so calculator starts off empty
    var currentOperation = Operation.Empty
    
    var leftValStr = ""
    
    var rightValStr = ""
    
    var result = ""
    
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
        
        //start the calculator at 0
        outputLbl.text = "0"
    }


    //You can create this IBAction in the view controller when it is empty, and then using the assistant editor drag the little plus on the left hand side (e.g. next to line 35 in this case) to all the buttons so that they can all call that action
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        //just in case someone is pressing the sound really fast to cancel it really fast
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    func processOperation(operation: Operation) {
        //add a sound by calling function playSound()
        playSound()
        
        // to ensure that the current operation is not pressed
        if currentOperation != Operation.Empty {
            
            //To ensure a user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                //note you turn the strings into doubles so that they can be computed
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

