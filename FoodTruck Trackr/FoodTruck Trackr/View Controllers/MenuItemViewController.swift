//
//  MenuItemViewController.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class MenuItemViewController: UIViewController {

    @IBOutlet weak var categorySegControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var decriptionTextView: UITextView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var menuItem: MenuItem? {
        didSet {
            updateViews()
        }
    }
    
    var menuController: MenuController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let price = priceTextField.text, !price.isEmpty,
            let image = imageView.image else { return }
                
        let description = decriptionTextView.text
        let categoryIndex = categorySegControl.selectedSegmentIndex
        let category = Category.allCases[categoryIndex]
                        
        let imageData: Data? = image
        
        if let menuItem = menuItem {
            // editing/updating an existing task
            menuItem.itemName = name
            menuItem.itemPrice = price
            menuItem.category = category.type
            menuItem.itemDescription = description
            menuController?.put(item: menuItem)
        } else {
            let menuItem = MenuItem(itemName: name,
                                    itemPrice: price,
                                    itemPhoto: String(from: image,
                                    itemDescription: description,
                                    category: category.type)
            menuController?.put(menuItem: menuItem)
        }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        
    }
    
   
}
