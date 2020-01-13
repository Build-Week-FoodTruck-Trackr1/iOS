//
//  ScheduleLocationViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit
import MapViewPlus
import CoreLocation

class ScheduleLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MapViewPlus!
    
    var delegate: ScheduleViewController?
    var selectedFieldTag: Int?
    private let locationManager = CLLocationManager()
    private var locationServiceAuthorized = false
    var currentLocation: CLLocation? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        startLocationServices()
    }

    @IBAction func saveTapped(_ sender: Any) {
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ScheduleLocationViewController: CLLocationManagerDelegate {
    func startLocationServices() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch locationAuthorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationServiceAuthorized = true
                self.locationManager.startUpdatingLocation()
                
            }
        case .restricted, .denied:
            locationServiceAuthorized = false
        @unknown default:
            locationServiceAuthorized = false
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationServiceAuthorized = true
                self.locationManager.startUpdatingLocation()
            }
        case .restricted, .denied:
            locationServiceAuthorized = false
        @unknown default:
            locationServiceAuthorized = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
}
