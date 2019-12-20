//
//  MenuItemViewController.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class MenuSectionPopover: UIViewController {
    
    @IBOutlet weak var AddAppetizer: UIButton!
    @IBOutlet weak var AddEntree: UIButton!
    @IBOutlet weak var AddSide: UIButton!
    @IBOutlet weak var AddDrink: UIButton!
    
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
        case "ShowAppetizer":
            if let detailVC = segue.destination as? MenuItemViewController {
                title = "Add Appetizer"
                
            }
        case "ShowEntree":
            if let detailVC = segue.destination as? MenuItemViewController {
                title = "Add Entree"

            }
        case "ShowSide":
            if let detailVC = segue.destination as? MenuItemViewController {
                title = "Add Side Dish"

            }
        case "ShowDrink":
            if let detailVC = segue.destination as? MenuItemViewController {
                title = "Add a Drink"

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
