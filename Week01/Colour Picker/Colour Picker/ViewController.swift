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
  
  @IBOutlet weak var firstSliderAttributeLabel: UILabel!
  @IBOutlet weak var secondSliderAttributeLabel: UILabel!
  @IBOutlet weak var thirdSliderAttributeLabel: UILabel!
  
  @IBOutlet var sliderValuesLabels: [UILabel]!
  
  @IBOutlet weak var firstSlider: UISlider!
  @IBOutlet weak var secondSlider: UISlider!
  @IBOutlet weak var thirdSlider: UISlider!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func sliders(_ sender: UISlider) {
    let sliderValue = String(Int(sender.value.rounded()))
    
    switch sender.tag {
    case 0:
      sliderValuesLabels[0].text = sliderValue
    case 1:
      sliderValuesLabels[1].text = sliderValue
    case 2:
      sliderValuesLabels[2].text = sliderValue
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
      preferredStyle: .alert)
    
    alert.addTextField { (textField) in
      textField.placeholder = "name the colour"
    }
    
    let action = UIAlertAction(
      title: "Done",
      style: .default)
    { [weak alert] (action) in
      let name = alert?.textFields![0].text
      let nameOfColour = name!.isEmpty ? "Unnamed colour" : name
      self.colourName.text = nameOfColour!
    }
    
    alert.addAction(action)
    present(alert, animated: true)
  }
  
  
  

}

