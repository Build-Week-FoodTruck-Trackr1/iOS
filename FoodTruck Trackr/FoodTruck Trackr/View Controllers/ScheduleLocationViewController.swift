//
//  ScheduleLocationViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit
import MapViewPlus

class ScheduleLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MapViewPlus!
    
    var delegate: ScheduleViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveTapped(_ sender: Any) {
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
    }
}
