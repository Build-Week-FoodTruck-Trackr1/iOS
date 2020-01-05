//
//  TruckLoginViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 1/3/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckLoginViewController: UIViewController {

    @IBOutlet weak var modeSegControl: UISegmentedControl!
    @IBOutlet weak var usernameFieldText: UITextField!
    @IBOutlet weak var passwordFieldText: UITextField!
    @IBOutlet weak var signUpLogInButton: UIButton!
    @IBOutlet weak var userOperatorToggle: UISwitch!
    
    override func viewDidLoad() {
           super.viewDidLoad {
       }
    
    }
    @IBAction func signUpLogInButtonPressed(_ sender: Any) {
    }
   
    @IBAction func userOperatorToggleTapped(_ sender: Any) {
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
