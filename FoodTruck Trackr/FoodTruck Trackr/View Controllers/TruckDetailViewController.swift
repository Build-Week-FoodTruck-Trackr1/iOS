//
//  TruckDetailViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/9/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var truckNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!

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
