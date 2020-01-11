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
    
    
    var user: User?
    var operatorStatus: Bool = false
    var foodTruck = [FoodTruckRepresentation]()
    var apiController: APIController?
    var type = "diner"
    override func viewDidLoad() {
        super.viewDidLoad()
        nameStackView.isHidden = false
   
    }
    
    
    @IBAction func signUpLogInButtonPressed(_ sender: Any) {
        guard let user = userNameTextField.text,
            let pass = passwordTextField.text,
            let location = currentLocationTextField.text,
            let email = emailTextField.text else { return }
        if modeSegControl.selectedSegmentIndex == 0 {
            // Sign IN
            
            let signInUser = User(username: user, password: pass, email: email, currentLocation: location, type: type)
     
            apiController?.LogIn(with: signInUser)
        } else if modeSegControl.selectedSegmentIndex == 1 {
            // Sign UP
            let signUpUser = User(username: user, password: pass, email: email, currentLocation: location, type: type)
            apiController?.signUp(with: signUpUser ) { (error) in
                if let error = error {
                    print("There was an error: \(error)")
                    
                } else {
                    DispatchQueue.main.async {
                         self.dismiss(animated: true)
                    }
                }
               
            }
                
        }
        
    }
    
   
    
    @IBAction func segmentControlToggled(_ sender: Any) {
        if modeSegControl.selectedSegmentIndex == 0 {
            signUpLogInButton.titleLabel?.text = "Sign In"
            nameStackView.isHidden = true
            
        } else if modeSegControl.selectedSegmentIndex == 1 {
            signUpLogInButton.titleLabel?.text = "Sign Up"
            nameStackView.isHidden = false
        }
    }
    
    @IBAction func operatorValueChanged(_ sender: Any) {
        operatorStatus.toggle()
        if operatorStatus == false {
            type = "diner"
        } else {
            type = "operator"
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
