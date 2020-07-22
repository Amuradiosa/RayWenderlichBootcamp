//
//  SandwichStore.swift
//  SandwichSaturation
//
//  Created by Ahmad Murad on 22/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

class SandwichStore {
  
  var sandwiches: [SandwichData] = []
  
  init() {
    loadJSONSandwiches()
  }
  
  private func loadJSONSandwiches() {
    guard let sandwichesJSONURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else { return }
    
    let decoder = JSONDecoder()
    
    do {
      let sandwichesData = try Data(contentsOf: sandwichesJSONURL)
      sandwiches = try decoder.decode([SandwichData].self, from: sandwichesData)
    } catch let error {
      print("Error loading or parsing sandwiches dataSet JSON \(error.localizedDescription)")
    }
  }
  
}
