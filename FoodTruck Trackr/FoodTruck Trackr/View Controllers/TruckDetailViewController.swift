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
    @IBOutlet private weak var cuisineLabel: UILabel!
    
    var apiController: APIController?
    var foodTruck: FoodTruck? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        var image: UIImage
        if let foodTruck = foodTruck,
            let imgURLString = foodTruck.imgUrl,
            let imgURL = URL(string: imgURLString) {
            let data = try? Data(contentsOf: imgURL)
            image = UIImage(data: data!) ?? UIImage(named: "notAvailable.jpg")!
        } else {
            image = UIImage(named: "notAvailable.jpg")!
        }
        imageView.image = image
        truckNameLabel.text = foodTruck?.name
        cuisineLabel.text = "Serving fine \(foodTruck?.cuisineType ?? "") cuisine"
    }

}
