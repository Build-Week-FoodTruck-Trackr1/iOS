//
//  ScheduleViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

enum AddressTag: Int {
    case current = 1
    case next = 2
}

enum TimeTag: Int {
    case currentDeparture = 1
    case nextArrival = 2
    case nextDeparture = 3
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
    var foodTruck: FoodTruck? { didSet { updateViews() } }
    
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
        
        title = foodTruck.name ?? "" + " Schedule"
        if user.type == "operator" {
            btnCancelCurrent.isHidden = false
            btnCancelNext.isHidden = false
        } else {
            btnCancelCurrent.isHidden = true
            btnCancelNext.isHidden = true
        }
        
        txtCurrentAddress.text = foodTruck.currentLocation
        if let cdt = foodTruck.currentDepartureTime {
            txtCurrentDepartureTime.text = formatter.string(from: cdt)
        }
        txtNextAddress.text = foodTruck.location
        if let arrivalTime = foodTruck.arrivalTime {
            txtNextArrivalTime.text = formatter.string(from: arrivalTime)
        }
        if let departureTime = foodTruck.departureTime {
            txtNextDepartureTime.text = formatter.string(from: departureTime)
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
                                          message: "Please enter a date in the format 'MM/dd/yyyy hh:mm' or tap the button to use the date picker.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return
        }
        saveTime(time: time, tag: sender.tag)
    }
    
    
    // MARK: Delegate methods
    public func saveLocation(loc: String, tag: Int) {

        guard let locTag = AddressTag(rawValue: tag),
            let foodTruck = self.foodTruck,
            let rep = foodTruck.truckRepresentation,
            let apiController = apiController
        else {
            print("Bad tag when saving location selection: \(tag)")
            return
        }
        
        switch locTag {
        case .current:
            rep.currentLocation = loc
            self.txtCurrentAddress.text = loc
        case .next:
            rep.location = loc
            self.txtNextAddress.text = loc
        }
        
        apiController.updateTruck(foodTruck, with: rep)
        
    }

    public func saveTime(time: Date, tag: Int) {
        guard let timeTag = TimeTag(rawValue: tag) else {
            print("Bad tag when saving time selection: \(tag)")
            return
        }
        let timeString = formatter.string(from: time)
        
        switch timeTag {
        case .currentDeparture:
            foodTruck?.currentDepartureTime = time
            txtCurrentDepartureTime.text = timeString
        case .nextArrival:
            foodTruck?.arrivalTime = time
            txtNextArrivalTime.text = timeString
        case .nextDeparture:
            foodTruck?.departureTime = time
            txtNextDepartureTime.text = timeString
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
