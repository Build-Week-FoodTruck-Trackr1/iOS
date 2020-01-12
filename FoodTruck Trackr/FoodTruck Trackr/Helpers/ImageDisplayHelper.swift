//
//  ImageDisplayHelper.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func displayURLImage(url: String) -> UIImage {
        let imageURL = URL(string: url)!
        let data = try? Data(contentsOf: imageURL)
        let image = UIImage(data: data!)
        return image ?? UIImage(named: "notAvailable.jpg")!
    }
}
