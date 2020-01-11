//
//  TruckDetailViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/9/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckDetailViewController: UIViewController {
    
    var apiController: APIController?
    var delegate: FoodTruck

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var delegate: FoodTruck? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
    }

}
