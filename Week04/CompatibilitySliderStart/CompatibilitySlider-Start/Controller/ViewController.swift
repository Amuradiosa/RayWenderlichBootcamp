//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var questionLabel: UILabel!
  
  // MARK: Variables
  private var compatibilityItems = ["Cats", "Dogs", "Guinea pigs", "Hamsters"] // Add more!
  private var currentItemIndex = 0
  
  private var person1 = Person(id: 1, items: [:])
  private var person2 = Person(id: 2, items: [:])
  private var currentPerson: Person?
  
  // MARK: Configuration
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  func configure() {
    currentPerson = person1
    updateViews()
  }
  
  // MARK: UI
  func updateViews() {
    questionLabel.text! = currentPerson == person1 ? "Person1, How do you feel about..." : "Person2, How do you feel about..."
    compatibilityItemLabel.text! = compatibilityItems[currentItemIndex]
    slider.value = 3
  }
  
  // MARK: Action
  @IBAction func didPressNextItemButton(_ sender: Any) {
    let currentItem = compatibilityItems[currentItemIndex]
    currentPerson?.items.updateValue(slider.value, forKey: currentItem)
    currentItemIndex += 1
    shallChangeCurrentUser()
    updateViews()
  }
  
  // MARK: functions
  func shallChangeCurrentUser() {
    if currentItemIndex >= compatibilityItems.count {
      currentItemIndex = 0
      if currentPerson == person1 {
        currentPerson = person2
      } else {
        currentPerson = person1
        updateViews()
        showAlert()
      }
    }
  }
  
  func showAlert() {
    let message = "You two are \(calculateCompatibility()) compatible."
    let alert = UIAlertController(title: "Results", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .cancel)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
  
  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    var percentagesForAllItems: [Double] = []
    
    for (key, person1Rating) in person1.items {
      let person2Rating = person2.items[key] ?? 0
      let difference = abs(person1Rating - person2Rating)/5.0
      percentagesForAllItems.append(Double(difference))
    }
    
    let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
    let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
    print(matchPercentage, "%")
    let matchString = 100 - (matchPercentage * 100).rounded()
    return "\(matchString)%"
  }
  
}

