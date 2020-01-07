//
//  TruckMainViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/5/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckMainViewController: UIViewController {
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    performSegue(withIdentifier: "ToLogin", sender: self)
        // Do any additional setup after loading the view.
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToLogin" {
            if let loginVC = segue.destination as? TruckLoginViewController {
                loginVC.self.self.user = self.user
            }
        }
    }
   
    

}
