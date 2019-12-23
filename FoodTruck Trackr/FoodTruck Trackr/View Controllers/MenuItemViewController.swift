//
//  MenuItemViewController.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class MenuSectionPopover: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
//    @IBAction func addAppButtonPressed(_ sender: UIButton) {
//    }
//
//    @IBAction func addEntreeButtonPressed(_ sender: UIButton) {
//    }
//
//    @IBAction func addSideButtonPressed(_ sender: UIButton) {
//    }
//
//    @IBAction func addDrinkButtonPressed(_ sender: UIButton) {
//    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddItem":
            if let detailVC = segue.destination as? MenuItemViewController {
                title = "Add Item"
                
            }
        case "ShowItemDetail":
            if let detailVC = segue.destination as? MenuItemViewController {
                title =

            }
        default:
            break
            
        }
    }
}

class MenuItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
