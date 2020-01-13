//
//  TruckDetailViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/9/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckDetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var truckNameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!
    @IBOutlet private weak var addMenuButton: UIButton!
    
    var apiController: APIController?
    var delegate: FoodTruck? {
           didSet {
               updateView()
           }
       }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        
    }

}
