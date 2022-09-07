//
//  DateViewController.swift
//  SayacApp
//
//  Created by Anıl Öncül on 6.09.2022.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var picker: UIDatePicker!
    
    public var completionHandler: ((String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pop up keyboard when the screen is loaded.
        field.becomeFirstResponder()
        picker.tintColor = .white

       
    }
    
    @IBAction func didTapButton() {
        if let text = field.text, !text.isEmpty {
            let pickedDateTime = picker.date
            completionHandler?(text, pickedDateTime)
            navigationController?.popToRootViewController(animated: true)
        }
        
    }


}
