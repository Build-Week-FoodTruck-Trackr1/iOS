//
//  TruckCollectionViewCell.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/9/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var truckImage: UIImageView!
    @IBOutlet weak var truckTitle: UILabel!
    
    @IBOutlet weak var truckID: UILabel!
    
    var truck: FoodTruckRepresentation? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let truck = self.truck, let image = truck.imageOfTruck else { return }
        truckImage.image = self.displayURLImage(url: image)
        truckTitle.text = truck.truckTitle
        truckID.text = "Truck ID: \(truck.truckID)"
        
    }
    
}
