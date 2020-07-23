//
//  SauceAmountModel+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Ahmad Murad on 23/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


public class SauceAmountModel: NSManagedObject {
  
  var sauceAmountCase: SauceAmount {
    get {
      guard let sauceAmountString = self.sauceAmountString, let amount = SauceAmount(rawValue: sauceAmountString) else { return .none }
      
      return amount
    }
    set {
      self.sauceAmountString = newValue.rawValue
    }
  }
  
}
