//
//  AlertHelper.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/9/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
// Alert code that alerts user of something. Input params title and message
   func alertMessage(title: String, message: String) {

       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
   }
    
}
