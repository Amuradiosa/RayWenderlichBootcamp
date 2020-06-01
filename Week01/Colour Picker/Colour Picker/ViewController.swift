//
//  ViewController.swift
//  Colour Picker
//
//  Created by Ahmad Murad on 31/05/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var colourName: UILabel!
  @IBOutlet weak var pickerSwitch: UISegmentedControl!
  
  @IBOutlet var slidersIdentityLabels: [UILabel]!
  
  @IBOutlet var slidersValuesLabels: [UILabel]!
  
  @IBOutlet var slidersOutlets: [UISlider]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func sliders(_ sender: UISlider) {
    let sliderValue = String(Int(sender.value.rounded()))
    
    switch sender.tag {
    case 0:
      slidersValuesLabels[0].text = sliderValue
    case 1:
      slidersValuesLabels[1].text = sliderValue
    case 2:
      slidersValuesLabels[2].text = sliderValue
    default:
      break
    }
  }
  

  @IBAction func setColour(_ sender: Any) {
    setBackgroundColour()
    showAlert()
  }
  
  func setBackgroundColour() {
    
  }
  
  func showAlert() {
    let alert = UIAlertController(
      title: "Name of the colour",
      message: "Give your colour a fancy name",
      preferredStyle: .alert
    )
    
    alert.addTextField { (textField) in
      textField.placeholder = "Name the colour"
    }
    
    let action = UIAlertAction(
      title: "Done",
      style: .default)
    { [weak alert] (action) in
      let enteredText = alert?.textFields![0].text
      let nameOfColour = enteredText!.isEmpty ? "Unnamed colour" : enteredText
      self.colourName.text = nameOfColour!
    }
    
    alert.addAction(action)
    present(alert, animated: true)
  }
  
  
  

}

