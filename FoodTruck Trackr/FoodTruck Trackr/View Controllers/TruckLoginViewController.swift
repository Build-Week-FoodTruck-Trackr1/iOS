//
//  TruckLoginViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe Thunder on 1/3/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit

class TruckLoginViewController: UIViewController {

    @IBOutlet private weak var modeSegControl: UISegmentedControl!
    @IBOutlet private weak var signUpLogInButton: UIButton!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var truckNameTextField: UITextField!
    @IBOutlet private weak var nameStackView: UIStackView!
    @IBOutlet private weak var currentLocationTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var isOperatorSwitch: UISwitch!
    @IBOutlet private weak var truckLabel: UILabel!
    
    var apiController: APIController?
    var user: User?
    var operatorStatus: Bool = false
    var foodTruck = [FoodTruckRepresentation]()
    var type = "diner"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameStackView.isHidden = true
        truckNameTextField.isHidden = true
        truckLabel.isHidden = true
    }
    
    
    @IBAction func signUpLogInButtonPressed(_ sender: Any) {
        
        guard let user = userNameTextField.text,
            let pass = passwordTextField.text,
            let location = currentLocationTextField.text,
            let email = emailTextField.text else { return }
        if user.isEmpty || pass.isEmpty || email.isEmpty {
            self.alertMessage(title: "Problem Signing In",
                              message: "A field was left blank or the username or password doesn't match up. Please correct and try again.")
            return
        }
        
        if modeSegControl.selectedSegmentIndex == 0 {
            // Sign IN
            let type = isOperatorSwitch.isOn ? "operator" : "diner"
            
            let signInUser = User(username: user, password: pass, email: email, currentLocation: location, type: type)
            apiController?.LogIn(with: signInUser)
            if self.apiController?.bearer?.token.isEmpty == true {
                DispatchQueue.main.async {
                      self.alertMessage(title: "There's a problem", message: "Your username or password aren't valid. Please try again.")
                }
            } else {
                DispatchQueue.main.async {
                            self.dismiss(animated: true)
                       }
            }
        } else if modeSegControl.selectedSegmentIndex == 1 {
            let type = isOperatorSwitch.isOn ? "operator" : "diner"

            // Sign UP
            let signUpUser = User(username: user, password: pass, email: email, currentLocation: location, type: type)
            apiController?.signUp(with: signUpUser ) { error in
                if let error = error {
                    print("There was an error: \(error)")
                    DispatchQueue.main.async {
                        self.alertMessage(title: "There was an error signing up.", message: "Please Try again.")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.modeSegControl.selectedSegmentIndex = 0
                        self.alertMessage(title: "Sign up successful.", message: "Please Sign in.")
                    }
                    
                }
               
            }
                
        }
        
    }
    
    @IBAction func segmentControlToggled(_ sender: Any) {
        if modeSegControl.selectedSegmentIndex == 0 {
            signUpLogInButton.titleLabel?.text = "Sign In"
            nameStackView.isHidden = true
            truckNameTextField.isHidden = true
            truckLabel.isHidden = true
            
        } else if modeSegControl.selectedSegmentIndex == 1 {
            signUpLogInButton.titleLabel?.text = "Sign Up"
            nameStackView.isHidden = false
        }
    }
    
    @IBAction func operatorValueChanged(_ sender: Any) {
        operatorStatus.toggle()
        let type = isOperatorSwitch.isOn ? "operator" : "diner"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
