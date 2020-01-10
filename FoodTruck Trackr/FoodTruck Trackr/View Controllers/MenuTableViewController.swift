//
//  MenuTableViewController.swift
//  FoodTruck Trackr
//
//  Created by Jessie Ann Griffin on 12/18/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController {

    private let menuController = MenuController()

        lazy var fetchedResultsController: NSFetchedResultsController<MenuItem> = {
            let fetchRequest: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(key: "menuItem", ascending: true),
                NSSortDescriptor(key: "itemName", ascending: true)
            ]
            let moc = CoreDataStack.shared.mainContext
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                 managedObjectContext: moc,
                                                 sectionNameKeyPath: "menuItem",
                                                 cacheName: nil)
            frc.delegate = self
            do {
                try frc.performFetch()
            } catch {
                print("Error performing menu fetch")
            }
            return frc
            
        }()

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }

//        @IBAction func shouldRefresh(_ sender: Any) {
//            menuController.fetchTasksFromServer{(_) in
//                DispatchQueue.main.async {
//                    self.refreshControl?.endRefreshing()
//                }
//            }
//        }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let categories = menuController.categories else { return 0 }
        
        return categories.count
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddItem":
            if let detailVC = segue.destination as? MenuItemViewController {
                title = "Add Item"
                
            }
        case "ShowItemDetail":
            if let detailVC = segue.destination as? MenuItemViewController {
                
            }
        default:
            break
            
        }
       }

}

extension MenuTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else { return }
//            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default: // @unknown is something in case apple changes this default case later
            break
        }
    }
}

