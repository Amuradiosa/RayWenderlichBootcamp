//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [SandwichData]()
  var filteredSandwiches = [SandwichData]()
  
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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func loadSandwiches() {
//    let sandwichArray = sandwichStore.sandwiches
//    sandwiches.append(contentsOf: sandwichArray)
    CoreDataManager.shared.refresh()
  }

  func saveSandwich(_ sandwich: SandwichData) {
    sandwiches.append(sandwich)
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: String) {
    CoreDataManager.shared.refresh(searchText, sauceAmount)
//    filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
//      let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount
//
//      if isSearchBarEmpty {
//        return doesSauceAmountMatch
//      } else {
//        return doesSauceAmountMatch && sandwhich.name.lowercased()
//          .contains(searchText.lowercased())
//      }
//    }
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let objs = CoreDataManager.shared.fetchedRC.fetchedObjects else {
      return 0
    }
    return objs.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
//    let sandwich = isFiltering ?
//      filteredSandwiches[indexPath.row] :
//      sandwiches[indexPath.row]
    let sandwich = CoreDataManager.shared.fetchedRC.object(at: indexPath)

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountCase.description

//    cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountString

    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount =
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    
    CoreDataManager.shared.refresh(searchBar.text!, sauceAmount)
    tableView.reloadData()
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    savedScopeButtonIndex = selectedScope
    let sauceAmount = searchBar.scopeButtonTitles![selectedScope]
    
    CoreDataManager.shared.refresh(searchBar.text!, sauceAmount)
    tableView.reloadData()
  }
}

