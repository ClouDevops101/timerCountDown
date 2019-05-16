//
//  ViewController.swift
//  timercountdown
//
//  Created by Abdelilah Heddar on 14/05/2019.
//  Copyright © 2019 Abdelilah Heddar. All rights reserved.
//

import Cocoa
// An extention to enable fetching number from string and cleaning  whitespace
extension String {
    // detect if string holds numbers
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
    // clean white space
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
class ViewController: NSViewController {

    // Time displayer
    @IBOutlet weak var timerLabel: NSTextField!
    

    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false  // this will be used to hold the state of the resume button
    var startTapped = false  // this will be used to hold the state of the start button
    
    @IBOutlet weak var numberOfHours: NSTextField!
    
    
    @IBAction func StartButtonTapped(_ sender: Any) {
        var hours = numberOfHours.stringValue
        hours = hours.removingWhitespaces()
        if hours.isEmpty || !hours.isNumber {
            hours = "1"
        }
        //let hoursString = hours.trimmingCharacters(in: .whitespaces)
        //let hoursString = hours.removingWhitespaces()
        seconds = 3600 * Int(hours)!
        if self.isTimerRunning == false {
            
            runTimer()
            self.isTimerRunning = true
        }
        
    }
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    @IBOutlet weak var `break`: NSButton!
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if self.resumeTapped == false && self.isTimerRunning == true {
            timer.invalidate()
            self.resumeTapped = true
            //Change pause button color
            //let aColor = NSColor(named: NSColor.Name("yellow"))
            //self.break.contentTintColor = aColor
           // self.break.image = #imageLiteral(resourceName: "turkey.png")
            self.isTimerRunning = false
            
        } else if self.resumeTapped == true && self.isTimerRunning == false {
            runTimer()
            self.isTimerRunning = true
            self.resumeTapped = false
            self.break.image = nil
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timer.invalidate()
        var hours = numberOfHours.stringValue
        hours = hours.removingWhitespaces()
        if hours.isEmpty || !hours.isNumber {
            hours = "1"
        }
       
        seconds = 3600 * Int(hours)!
        //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.stringValue = timeString(time: TimeInterval(seconds))
        self.isTimerRunning = false
        self.resumeTapped = false
    }
    
    

    @objc func updateTimer() {
        if seconds != 0 {
            seconds -= 1
        } else if seconds == 0 {
            timer.invalidate()
            let answer = dialogOKCancel(question: "TIME IS UP?", text: "Hurry up")
            
            // Showing the different case responders
            //switch answer {
            //case NSAlertFirstButtonReturn:
            //    print("first button")
             
            //}
            
        }
            //This will decrement(count down)the seconds.
       // timerLabel.stringValue = "\(seconds)" //This will update the label.
        timerLabel.stringValue = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

