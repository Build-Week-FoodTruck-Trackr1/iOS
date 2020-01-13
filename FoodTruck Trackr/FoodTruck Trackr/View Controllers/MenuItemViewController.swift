//
//  MenuItemViewController.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/19/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit
import StarRatingControl

class MenuItemViewController: UIViewController {

    @IBOutlet private weak var categorySegControl: UISegmentedControl!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var decriptionTextView: UITextView!
    @IBOutlet private weak var addPhotoButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var itemRatingView: StarRatingControl!
    
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
                        
        let imageData: Data? = image.pngData()
        
        if let menuItem = menuItem {
            // editing/updating an existing item
            menuController?.createMenuItem(with: name, price: price, photo: imageData, description: description)
        } else {
            let menuItem = MenuItem(itemName: name,
                                    itemPrice: price,
                                    itemPhoto: imageData,
                                    itemDescription: description,
                                    category: category)
            menuController?.put(item: menuItem)
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
        guard isViewLoaded else { return } // so we don't try to update the views before the view is loaded
        
        title = menuItem?.itemName ?? "Create Item"
        nameTextField.text = menuItem?.itemName
        
        var category: Category
        if let itemCategoryString = menuItem?.category, let itemCategory = Category(typeName: itemCategoryString) {
            category = itemCategory
        } else {
            category = .entree
        }
        if let index = Category.allCases.firstIndex(of: category) {
            categorySegControl.selectedSegmentIndex = index
        }
        priceTextField.text = menuItem?.itemPrice
        decriptionTextView.text = menuItem?.description
        
        if let photoData = menuItem?.itemPhoto {
            imageView.image = UIImage(data: photoData)
        }
    }
}
