//
//  ScheduleViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

enum AddressTag: Int {
    case current = 0
    case next = 1
}

enum TimeTag: Int {
    case currentDeparture = 0
    case nextArrival = 1
    case nextDeparture = 2
}

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak private var txtCurrentAddress: UITextField!
    @IBOutlet weak private var txtCurrentDepartureTime: UITextField!
    @IBOutlet weak private var txtNextAddress: UITextField!
    @IBOutlet weak private var txtNextArrivalTime: UITextField!
    @IBOutlet weak private var txtNextDepartureTime: UITextField!
    
    var foodTruck: FoodTruck?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let foodTruck = foodTruck else { return }
        
        title = foodTruck.truckTitle ?? "" + " Schedule"
    }

    @IBAction func addressFieldTapped(_ sender: UITextField) {
        self.performSegue(withIdentifier: "SegueChooseLocation", sender: sender)
    }
    
    @IBAction func timeFieldTapped(_ sender: UITextField) {
        self.performSegue(withIdentifier: "SegueChooseTime", sender: sender)
    }
    
    // MARK: Delegate methods
    public func saveLocation(loc: String, tag: Int) {
        guard let locTag = AddressTag(rawValue: tag) else {
            print("Bad tag when saving location selection: \(tag)")
            return
        }
        
        switch locTag {
        case .current:
            self.foodTruck?.currentLocation = loc
        case .next:
            self.foodTruck?.location = loc
        }
    }

    public func saveTime(time: Date, tag: Int) {
        guard let timeTag = TimeTag(rawValue: tag) else {
            print("Bad tag when saving time selection: \(tag)")
            return
        }
        
        switch timeTag {
        case .currentDeparture:
            foodTruck?.currentDepartureTime = time
        case .nextArrival:
            foodTruck?.arrivalTime = time
        case .nextDeparture:
            foodTruck?.departureTime = time
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueChooseLocation" {
            guard let vc = segue.destination as? ScheduleLocationViewController,
                let sender = sender as? UITextField
            else { return }
            vc.delegate = self
            vc.selectedFieldTag = sender.tag
        } else if segue.identifier == "SegueChooseTime" {
            guard let vc = segue.destination as? ScheduleTimeViewController,
                let sender = sender as? UITextField
                else { return }
            vc.delegate = self
            vc.selectedFieldTag = sender.tag
        }
    }


}
