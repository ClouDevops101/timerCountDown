//
//  ViewController.swift
//  timercountdown
//
//  Created by Abdelilah Heddar on 14/05/2019.
//  Copyright © 2019 Abdelilah Heddar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var timerLabel: NSTextField!
    

    var seconds = 0//This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    @IBOutlet weak var numberOfHours: NSTextField!
    
    
    @IBAction func StartButtonTapped(_ sender: Any) {
        var hours = numberOfHours.stringValue
        if hours.isEmpty ||  hours == "hours.." {
            hours = "1"
        }
        seconds = 3600 * Int(hours)!
        runTimer()
    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timer.invalidate()
        var hours = numberOfHours.stringValue
        if hours.isEmpty {
            hours = "1"
        }
        seconds = 3600 * Int(hours)!
        //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.stringValue = timeString(time: TimeInterval(seconds))
    }
    
    

    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
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

