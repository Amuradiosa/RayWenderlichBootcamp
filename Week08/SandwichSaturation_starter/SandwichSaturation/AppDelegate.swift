//
//  AppDelegate.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    if launchedBefore {
//      print("Not First launch")
    } else {
      let sandwiches = SandwichStore().sandwiches
      CoreDataManager.shared.refresh()
      
      for initialSandwich in sandwiches {
        
        let sandwich = SandwichModel(entity: SandwichModel.entity(), insertInto: CoreDataManager.shared.context)
        let sauceAmount = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: CoreDataManager.shared.context)
        
        sandwich.name = initialSandwich.name
        sandwich.imageName = initialSandwich.imageName
        sauceAmount.sauceAmountCase = initialSandwich.sauceAmount
        sauceAmount.sandwich = sandwich
      }
      
      CoreDataManager.shared.appDelegate.saveContext()
      UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    return true
  }
  
  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      
      let container = NSPersistentContainer(name: "SandwichSaturation")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

