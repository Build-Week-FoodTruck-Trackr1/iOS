//
//  ScheduleTimeViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class ScheduleTimeViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: ScheduleViewController?
    var time: Date?
    var selectedFieldTag: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let time = time {
            datePicker.date = time
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let time = time,
            let selectedFieldTag = selectedFieldTag
        else { return }
        delegate?.saveTime(time: time, tag: selectedFieldTag)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
