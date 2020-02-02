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

        updateView()
    }
    
    func updateView() {
        guard isViewLoaded else { return }
        DispatchQueue.main.async {
            var image: UIImage
            if let foodTruck = self.foodTruck,
                let imgURLString = foodTruck.imgUrl,
                let imgURL = URL(string: imgURLString) {
                let data = try? Data(contentsOf: imgURL)
                image = UIImage(data: data!) ?? UIImage(named: "notAvailable.jpg")!
            } else {
                image = UIImage(named: "notAvailable.jpg")!
            }
            self.imageView.image = image
            self.truckNameLabel.text = self.foodTruck?.name
            self.cuisineLabel.text = "Serving fine \(self.foodTruck?.cuisineType ?? "") cuisine"
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSchedule" {
            guard let vc = segue.destination as? ScheduleViewController,
                let apiController = apiController,
                let foodTruck = foodTruck
            else {
                return
            }
            vc.apiController = apiController
            vc.foodTruck = foodTruck
        } else if segue.identifier == "ToMenu" {
            
        }
    }
}
