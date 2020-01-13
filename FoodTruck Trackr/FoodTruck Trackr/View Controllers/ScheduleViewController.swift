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
    
    @IBOutlet private weak var txtCurrentAddress: UITextField!
    @IBOutlet private weak var txtCurrentDepartureTime: UITextField!
    @IBOutlet private weak var txtNextAddress: UITextField!
    @IBOutlet private weak var txtNextArrivalTime: UITextField!
    @IBOutlet private weak var txtNextDepartureTime: UITextField!
    @IBOutlet private weak var btnCancelCurrent: UIButton!
    @IBOutlet private weak var btnCancelNext: UIButton!
    
    var apiController: APIController? { didSet { updateViews() } }
    var foodTruck: FoodTruckRepresentation? { didSet { updateViews() } }
    
    let formatter = DateFormatter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded,
            let foodTruck = foodTruck,
            let user = apiController?.user
        else { return }
        
        title = foodTruck.name + " Schedule"
        if user.type == "operator" {
            btnCancelCurrent.isHidden = false
            btnCancelNext.isHidden = false
        } else {
            btnCancelCurrent.isHidden = true
            btnCancelNext.isHidden = true
        }
    }

    @IBAction func addressFieldTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SegueChooseLocation", sender: sender)
    }
    
    @IBAction func timeFieldTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SegueChooseTime", sender: sender)
    }
    
    
    @IBAction func addressManuallyChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        saveLocation(loc: text, tag: sender.tag)
    }
    
    @IBAction func timeManuallyChanged(_ sender: UITextField) {
        guard let timeString = sender.text,
            let time = formatter.date(from: timeString) else {
            let alert = UIAlertController(title: "Invalid Date",
                message: "Please enter a date in the format 'MM/dd/yyyy hh:mm'. If you're having trouble, tap the button to use the date picker.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return
        }
        saveTime(time: time, tag: sender.tag)
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
            foodTruck?.currentDepartureTime = formatter.string(from: time)
        case .nextArrival:
            foodTruck?.arrivalTime = formatter.string(from: time)
        case .nextDeparture:
            foodTruck?.departureTime = formatter.string(from: time)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueChooseLocation" {
            guard let vc = segue.destination as? ScheduleLocationViewController,
                let sender = sender as? UIButton
            else { return }
            vc.delegate = self
            vc.selectedFieldTag = sender.tag
        } else if segue.identifier == "SegueChooseTime" {
            guard let vc = segue.destination as? ScheduleTimeViewController,
                let sender = sender as? UIButton
                else { return }
            vc.delegate = self
            vc.selectedFieldTag = sender.tag
        }
    }

}
