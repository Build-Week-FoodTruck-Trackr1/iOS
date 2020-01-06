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
    @IBOutlet weak var signUpLogInButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var truckNameTextField: UITextField!
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var currentLocationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var isOperatorSwitch: UISwitch!
    
    
    let user: User?
    let operatorStatus: Bool = false
    let foodTrucks = [FoodTruck]
    let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad {
            truckNameLabel.isHidden = true
            truckNameTextField.isHidden = true
            nameStackView.isHidden = true
        }
    }
    
    @IBAction func signUpLogInButtonPressed(_ sender: Any) {
        guard let user = userNameTextField.text, let pass = passwordTextField.text, let location = currentLocationTextField.text, let email = emailTextField.text else { return }
        if modeSegControl.selectedSegmentIndex = 0 {
            // Sign IN
            
            let signInUser = User(userName: user, password: pass, currentLocation: location, email: email, isOperator: operatorStatus)
            apiController.LogIn(with: user)
        } else if modeSegControl.selectedSegmentIndex = 1 {
            // Sign UP
            let signUpUser = User(username: user, password: pass, currentLocation: location, email: email, trucksOwned: foodTrucks, isOperator: operatorStatus)
            apiController.signUp(signUpUser)
        }
    }
    
    func Auth(user: User) {
        
    }
    
    @IBAction func segmentControlToggled(_ sender: Any) {
        if modeSegControl.selectedSegmentIndex = 0 {
            signUpLogInButton.titleLabel.text = "Sign In"
            nameStackView.isHidden = true
            
        } else if modeSegControl.selectedSegmentIndex = 1 {
            signUpLogInButton.titleLabel.text = "Sign Up"
            nameStackView.isHidden = false
        }
    }
    
    @IBAction func operatorValueChanged(_ sender: Any) {
        operatorStatus.toggle()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
