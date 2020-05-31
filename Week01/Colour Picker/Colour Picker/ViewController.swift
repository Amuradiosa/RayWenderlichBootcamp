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
  
  @IBOutlet weak var firstSliderValueLabel: UILabel!
  @IBOutlet weak var secondSliderValueLabel: UILabel!
  @IBOutlet weak var thirdSliderValueLabel: UILabel!
  
  @IBOutlet weak var firstSlider: UISlider!
  @IBOutlet weak var secondSlider: UISlider!
  @IBOutlet weak var thirdSlider: UISlider!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func setColour(_ sender: Any) {
    showAlert()
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

