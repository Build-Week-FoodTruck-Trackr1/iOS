//
//  ScheduleViewController.swift
//  FoodTruck Trackr
//
//  Created by Joel Groomer on 1/11/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var txtCurrentAddress: UITextField!
    @IBOutlet weak var txtCurrentDepartureTime: UITextField!
    @IBOutlet weak var txtNextAddress: UITextField!
    @IBOutlet weak var txtNextArrivalTime: UITextField!
    @IBOutlet weak var txtNextDepartureTime: UITextField!
    
    var foodTruck: FoodTruck?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let foodTruck = foodTruck else { return }
        
        title = foodTruck.truckTitle ?? "" + " Schedule"
    }

    @IBAction func addressFieldTapped(_ sender: UITextField) {
    }
    
    @IBAction func timeFieldTapped(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
