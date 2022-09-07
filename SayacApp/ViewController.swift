//
//  ViewController.swift
//  SayacApp
//
//  Created by Anıl Öncül on 6.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    func makeLabelShine(label: UILabel) {
        label.layer.shadowColor = UIColor.yellow.cgColor
        label.layer.shadowRadius = 10.0
        label.layer.shadowOpacity = 1.0
        label.shadowOffset = .zero
    }
    
    func makeImageLabelAnimate(label: UIView) {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.autoreverse, .curveEaseInOut, .repeat, .allowUserInteraction], animations: { () -> Void  in
            label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)},
                        completion: {(finished: Bool) -> Void in
            label.layer.shadowRadius = 0.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
        })
    }
    
   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabel2: UILabel!
    @IBOutlet weak var imageLabel: UIView!
    
    var hrs: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    var days: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "00 : 00 : 00 : 00"
        makeLabelShine(label: timeLabel)
        
        
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
            let Days: Int = Int(difference) / 86400
            let remainderHours: Int = Int(difference) - (Days * 86400)
            let hours: Int = remainderHours / 3600
            let remainder: Int = Int(difference) - (Days * 86400) - (hours * 3600 )
            let minutes: Int = remainder / 60
            let seconds: Int = Int(difference) - (Days * 86400) - (hours * 3600 ) - (minutes * 60 )
            
            print(" \(Days) :\(hours) : \(minutes) : \(seconds)")
            hrs = hours
            mins = minutes
            secs = seconds
            days = Days
            
            updateLabel()
            startTimer()
            
            makeImageLabelAnimate(label: imageLabel)
                
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
            else if self.days > 0 && self.hrs == 0 && self.mins == 0 && self.secs == 0 {
                self.days = self.days - 1
                self.hrs = 23
                self.mins = 59
                self.secs = 59
            }
            self.updateLabel()
        })
    }
    
    private func updateLabel() {
        timeLabel.text = " \(days) : \(hrs) : \(mins) : \(secs)"
        
    }
}

