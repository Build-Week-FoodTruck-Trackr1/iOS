//
//  MenuItemTableViewCell.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/18/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemRatingView: UIView!
    
    var item: MenuItem? { didSet { updateViews() } }
    
    func updateViews() {
        itemNameLabel.text = item?.itemName
    }
}
