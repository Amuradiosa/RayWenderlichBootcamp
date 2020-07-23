//
//  CoreDataManager.swift
//  SandwichSaturation
//
//  Created by Ahmad Murad on 22/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  private init() { }
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var fetchedRC: NSFetchedResultsController<SandwichModel>!
  
  
  func refresh(_ searchText: String? = nil,_
    sauceAmount: String? = nil) {
    let request = SandwichModel.fetchRequest() as NSFetchRequest<SandwichModel>
    
    if (searchText == nil && sauceAmount == nil) || (searchText!.isEmpty && sauceAmount == "Either") {
      
    } else if searchText!.isEmpty {
      request.predicate = NSPredicate(format: "sauceAmount.sauceAmountString = %@", sauceAmount!)
    } else {
      if sauceAmount == "Either" {
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText!)
      } else {
        request.predicate = NSPredicate(format: "sauceAmount.sauceAmountString = %@ AND name CONTAINS[cd] %@", sauceAmount!, searchText!)
      }
    }
    
    let sort = NSSortDescriptor(keyPath: \SandwichModel.imageName, ascending: true)
    request.sortDescriptors = [sort]
    
    fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    do {
      try fetchedRC.performFetch()
    } catch let error as NSError {
      print("Couldn't fetch. \(error), \(error.userInfo)")
    }
  }
  
}
