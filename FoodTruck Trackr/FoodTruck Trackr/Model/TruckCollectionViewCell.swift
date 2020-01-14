//
//  TruckCollectionViewCell.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/9/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var truckImage: UIImageView!
    @IBOutlet private weak var truckTitle: UILabel!
    @IBOutlet private weak var truckID: UILabel!
    
    var truck: FoodTruck? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let truck = self.truck, let image = truck.imgUrl else { return }
        truckImage.image = self.displayURLImage(url: image)
        truckTitle.text = truck.name
        truckID.text = "Truck ID: \(truck.id)"
        
    }
    
}
