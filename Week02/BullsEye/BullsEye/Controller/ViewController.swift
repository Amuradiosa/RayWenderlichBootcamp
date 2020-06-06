//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var bullsEyeGame = BullsEyeGame()
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
  }

  @IBAction func showAlert() {
    let (points, title) = bullsEyeGame.pointsAndFeedback()
    let message = "You scored \(points) points"
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      self.startNewRound()
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    bullsEyeGame.currentValue = Int(roundedValue)
  }
  
  func startNewRound() {
    bullsEyeGame.startNewRound()
    slider.value = Float(bullsEyeGame.currentValue)
    updateLabels()
  }
  
  func updateLabels() {
    targetLabel.text = String(bullsEyeGame.targetValue)
    scoreLabel.text = String(bullsEyeGame.score)
    roundLabel.text = String(bullsEyeGame.round)
  }
  
  @IBAction func startNewGame() {
    bullsEyeGame.startNewGame()
    startNewRound()
  }
  
}



