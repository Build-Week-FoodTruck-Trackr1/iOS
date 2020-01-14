//
//  TruckCollectionViewController.swift
//  FoodTruck Trackr
//
//  Created by Joe on 1/6/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class TruckCollectionViewController: UICollectionViewController {

    
    var apiController = APIController()
    lazy var fetchedResultsController: NSFetchedResultsController<FoodTruck> = {
        let fetchRequest: NSFetchRequest<FoodTruck> = FoodTruck.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            print("FRC ERROR")
        }
        return frc
    }()

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
        collectionView.reloadData()
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
            guard let detailVC = segue.destination as? TruckDetailViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first
            else {
                return
            }
            detailVC.apiController = self.apiController
            detailVC.foodTruck = fetchedResultsController.object(at: indexPath)
            
        } else if segue.identifier == "AddTruck" {
            if let detailVC = segue.destination as? TruckDetailViewController {
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
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TruckCell", for: indexPath) as? TruckCollectionViewCell else {
            print("Dequeue Failed!")
            return UICollectionViewCell()
            
        }
        cell.truck = fetchedResultsController.object(at: indexPath)
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

extension TruckCollectionViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            collectionView.insertSections(IndexSet(integer: sectionIndex))
        case .delete:
            collectionView.deleteSections(IndexSet(integer: sectionIndex))
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // newIndexPath is option bc you'll only get it for insert and move
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            collectionView.insertItems(at: [newIndexPath])
        case .update:
            guard let indexPath = indexPath else { return }
            collectionView.reloadItems(at: [indexPath])
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else { return }
            collectionView.moveItem(at: oldIndexPath, to: newIndexPath)
        case .delete:
            guard let indexPath = indexPath else { return }
            collectionView.deleteItems(at: [indexPath])
        @unknown default:
            break
        }
    }
}
