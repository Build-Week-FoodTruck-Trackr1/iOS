//
//  ScheduleLocationViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit
import MapKit
import MapViewPlus
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

class ScheduleLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MapViewPlus!
    
    weak var delegate: ScheduleViewController?
    var selectedFieldTag: Int?
    private let locationManager = CLLocationManager()
    private var locationServiceAuthorized = false
    var currentLocation: CLLocation?
    var address: String?
    var resultSearchController: UISearchController?
    var selectedPin: MKPlacemark?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            startLocationServices()
            if let location = locationManager.location {
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        } else {
            
        }
        
        guard let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "locationTVC") as? LocationSearchTableViewController else {
            fatalError("locationTVC not found in storyboard.")
        }
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    func startLocationServices() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch locationAuthorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationServiceAuthorized = true
                self.locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
            }
        case .restricted, .denied:
            locationServiceAuthorized = false
        @unknown default:
            locationServiceAuthorized = false
        }
    }

    @IBAction func saveTapped(_ sender: Any) {
        if let address = address,
            let selectedFieldTag = selectedFieldTag {
            delegate?.saveLocation(loc: address, tag: selectedFieldTag)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ScheduleLocationViewController: CLLocationManagerDelegate {
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
        if let location = locations.last {
            self.currentLocation = location
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("MapKit error: \(error)")
    }
}

extension ScheduleLocationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark) {
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? "")"
    }
}
