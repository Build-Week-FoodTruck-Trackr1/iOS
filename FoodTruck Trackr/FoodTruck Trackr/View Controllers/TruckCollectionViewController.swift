//
//  TruckCollectionViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/6/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "TruckCell"

class TruckCollectionViewController: UICollectionViewController {

    
    var apiController = APIController()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        apiController.fetchTrucksFromServer { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if apiController.bearer == nil {
            performSegue(withIdentifier: "ToLogin", sender: self)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToLogin" {
            if let loginVC = segue.destination as? TruckLoginViewController {
                loginVC.apiController = self.apiController
            }
        } else if segue.identifier == "ToTruckDetail" {
            if let detailVC = segue.destination as? TruckLoginViewController {
                detailVC.apiController = self.apiController
            }
        } else if segue.identifier == "AddTruck" {
            if let detailVC = segue.destination as? TruckLoginViewController {
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }


    override  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return apiController.foodTruck.count
    }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TruckCollectionViewCell else {
                print("Dequeue Failed!")
                return UICollectionViewCell()
               
            }
            let truck = apiController.foodTruck[indexPath.item]
            cell.truck = truck
            print("\(truck.name)")
            print("\(truck.imgUrl ?? "")")
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
