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
        try! frc.performFetch()
        return frc
        
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
//    @IBAction func shouldRefresh(_ sender: Any) {
//        menuController.fetchItemsFromServer{(_) in
//            DispatchQueue.main.async {
//                self.refreshControl?.endRefreshing()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return tasks.count
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return nil }
        guard let sectionName = Category(rawValue: Int16(sectionInfo.name)!) else { return nil }
        return sectionName.type.capitalized
    }
        

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as?
            MenuItemTableViewCell else { return UITableViewCell() }
        
        if let items = menuController.menuItems {
            cell.itemNameLabel.text = items[indexPath.row].itemName
        }

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            if let addItemVC = segue.destination as? MenuItemViewController {
                title = "Add Item"
                addItemVC.menuController = menuController
            }
        } else if segue.identifier == "ShowItemDetail" {
            if let detailVC = segue.destination as? MenuItemViewController,
                let indexPath = tableView.indexPathForSelectedRow
            {
                if let items = menuController.menuItems {
                    title = items[indexPath.row].itemName
                }
                detailVC.menuController = menuController
            }
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

