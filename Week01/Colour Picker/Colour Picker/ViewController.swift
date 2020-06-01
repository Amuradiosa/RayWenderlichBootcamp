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
  @IBOutlet weak var modeSegment: UISegmentedControl!
       
  @IBOutlet var slidersIdentityLabels: [UILabel]!
  
  @IBOutlet var slidersValuesLabels: [UILabel]!
  
  @IBOutlet var slidersOutlets: [UISlider]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func modeSegmentChanged(_ sender: Any) {
    reconfigureUI()
    resetColour()
  }
  
  func reconfigureUI() {
    let RGB: [(factorName: String, colour: UIColor)] = [
      ("Red", UIColor.red),
      ("Green", UIColor.green),
      ("Blue", UIColor.blue)
    ]
    let HSB: [(factorName:String, maxValue:Float)] = [
      ("Hue",360),
      ("Saturation",100),
      ("Brightness",100)
    ]
    
    if modeSegment.selectedSegmentIndex == 0 {
      for i in slidersIdentityLabels.indices {
        slidersIdentityLabels[i].text = RGB[i].factorName
        slidersIdentityLabels[i].shadowColor = RGB[i].colour
        slidersOutlets[i].minimumTrackTintColor = RGB[i].colour
        slidersOutlets[i].maximumValue = 255
      }
    } else {
      for i in slidersIdentityLabels.indices {
        slidersIdentityLabels[i].text = HSB[i].factorName
        slidersIdentityLabels[i].shadowColor = UIColor.darkGray
        slidersOutlets[i].minimumTrackTintColor = UIColor.darkGray
        slidersOutlets[i].maximumValue = HSB[i].maxValue
      }
    }
  }
  
  @IBAction func sliders(_ sender: UISlider) {
    let sliderValue = String(Int(sender.value.rounded()))
    
    switch sender.tag {
    case 0:
      slidersValuesLabels[0].text = sliderValue
      slidersValuesLabels[0].backgroundColor = modeSegment.selectedSegmentIndex == 0 ?
        UIColor(
          red: CGFloat(slidersOutlets[0].value/255),
          green: 0,
          blue: 0,
          alpha: 1
        ) :
        UIColor.darkGray
    case 1:
      slidersValuesLabels[1].text = sliderValue
      slidersValuesLabels[1].backgroundColor = modeSegment.selectedSegmentIndex == 0 ?
        UIColor(
          red: 0,
          green: CGFloat(slidersOutlets[1].value/255),
          blue: 0,
          alpha: 1
        ) :
        UIColor.darkGray
    case 2:
      slidersValuesLabels[2].text = sliderValue
      slidersValuesLabels[2].backgroundColor = modeSegment.selectedSegmentIndex == 0 ?
        UIColor(
          red: 0,
          green: 0,
          blue: CGFloat(slidersOutlets[2].value/255),
          alpha: 1
        ) :
        UIColor.darkGray
    default:
      break
    }
  }
  
  @IBAction func setColour(_ sender: Any) {
    setBackgroundColour()
    showAlert()
  }
  
  func setBackgroundColour() {
    let resultColour: UIColor
    
    if modeSegment.selectedSegmentIndex == 0 {
      resultColour = UIColor(
        red: CGFloat(slidersOutlets[0].value/255),
        green: CGFloat(slidersOutlets[1].value/255),
        blue: CGFloat(slidersOutlets[2].value/255),
        alpha: 1
      )
    } else {
      resultColour = UIColor(
        hue: CGFloat(slidersOutlets[0].value/360),
        saturation: CGFloat(slidersOutlets[1].value/100),
        brightness: CGFloat(slidersOutlets[2].value/100),
        alpha: 1
      )
    }
    
    view.backgroundColor = resultColour
  }
  
  @IBAction func resetColourButton(_ sender: Any) {
    resetColour()
  }
  
  func resetColour() {
    view.backgroundColor = UIColor.white
    slidersOutlets.forEach { $0.value = 0.0 }
    slidersValuesLabels.forEach { $0.text = "" ; $0.backgroundColor = UIColor.white }
    colourName.text = ""
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

