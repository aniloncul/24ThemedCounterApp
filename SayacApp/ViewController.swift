//
//  ViewController.swift
//  SayacApp
//
//  Created by Anıl Öncül on 6.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    
    var hrs: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "00 : 00 : 00"
        
    }
    
    @IBAction func didTapAddButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "date_picker") as! DateViewController
        vc.title = "New Event"
        vc.completionHandler = { [weak self] name, date in
            DispatchQueue.main.async {
                self?.didCreateEvent(name: name, targetDate: date)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didCreateEvent(name: String, targetDate: Date) {
        self.title = name
        let difference = floor(targetDate.timeIntervalSince(Date()))
        if difference > 0.0 {
            let hours: Int = Int(difference) / 3600
            let remainder: Int = Int(difference) - (hours * 3600 )
            let minutes: Int = remainder / 60
            let seconds: Int = Int(difference) - (hours * 3600 ) - (minutes * 60 )
            
            print(" \(hours) : \(minutes) : \(seconds)")
            hrs = hours
            mins = minutes
            secs = seconds
            
            updateLabel()
            startTimer()
                
        }
        
       
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.secs > 0 {
                self.secs = self.secs - 1
            }
            else if self.mins > 0 && self.secs == 0 {
                self.mins = self.mins - 1
                self.secs = 59
            }
            else if self.hrs > 0 && self.mins == 0 && self.secs == 0 {
                self.hrs = self.hrs - 1
                self.mins = 59
                self.secs = 59
            }
            self.updateLabel()
        })
    }
    
    private func updateLabel() {
        timeLabel.text = " \(hrs) : \(mins) : \(secs)"
    }
}

