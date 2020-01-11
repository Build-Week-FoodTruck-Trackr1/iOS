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
    @IBOutlet weak var truckLocation: UILabel!
    
    let truck: FoodTruck? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let truckImage = truckImage, let truckTitle = truckTitle, let truckLocation = truckLocation else { return }
        
        
    }
    
}
