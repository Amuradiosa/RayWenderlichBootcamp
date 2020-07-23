//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

class SandwichViewController: UITableViewController {
  let searchController = UISearchController(searchResultsController: nil)
  
  let defaults = UserDefaults.standard
  let sauceAmountUserDefaultsKey = "ScopeBarIndex"
  
  var savedScopeButtonIndex: Int {
    get {
      let savedIndex = defaults.value(forKey: sauceAmountUserDefaultsKey)
      if savedIndex == nil {
        defaults.set( searchController.searchBar.selectedScopeButtonIndex, forKey: sauceAmountUserDefaultsKey )
      }
      return defaults.integer( forKey: sauceAmountUserDefaultsKey )
    }
    set {
      if newValue >= 0 && newValue < searchController.searchBar.scopeButtonTitles!.count {
        defaults.set ( newValue, forKey: sauceAmountUserDefaultsKey )
      }
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadSandwiches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.selectedScopeButtonIndex = savedScopeButtonIndex
    searchController.searchBar.delegate = self
  }
  
  func loadSandwiches() {
    CoreDataManager.shared.refresh()
    CoreDataManager.shared.fetchedRC.delegate = self
  }
  
  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  func filterContentForSearchText(searchText: String? = nil,
                                  sauceAmount: String? = nil) {
    CoreDataManager.shared.refresh(searchText, sauceAmount)
    CoreDataManager.shared.fetchedRC.delegate = self
    tableView.reloadData()
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return CoreDataManager.shared.fetchedRC.sections?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let objs = CoreDataManager.shared.fetchedRC.fetchedObjects else {
      return 0
    }
    return objs.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = CoreDataManager.shared.fetchedRC.object(at: indexPath)
    
    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountCase.description
        
    return cell
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let delete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
      self.deleteSandwich(at: indexPath)
    }
    
    return UISwipeActionsConfiguration(actions: [delete])
  }
  
  func deleteSandwich(at indexPath: IndexPath) {
    if let sandwich = CoreDataManager.shared.fetchedRC?.object(at: indexPath) {
      CoreDataManager.shared.context.delete(sandwich)
      CoreDataManager.shared.appDelegate.saveContext()
    }
  }
  
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount =
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    
    filterContentForSearchText(searchText: searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
                 selectedScopeButtonIndexDidChange selectedScope: Int) {
    savedScopeButtonIndex = selectedScope
    let sauceAmount = searchBar.scopeButtonTitles![selectedScope]
    
    filterContentForSearchText(searchText: searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - Fetched Results Controller Delegate
extension SandwichViewController: NSFetchedResultsControllerDelegate {
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    let index = indexPath ?? (newIndexPath ?? nil)
    guard let rowIndex = index else {
      return
    }
    
    switch type {
    case .insert:
      tableView.insertRows(at: [rowIndex], with: .automatic)
    case .delete:
      tableView.deleteRows(at: [rowIndex], with: .automatic)
    default:
      break
    }
    
  }
  
}
