//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var game = BullsEyeGame(gameMaxValue: 100)
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
  }

  @IBAction func showAlert() {
    let difference = abs(game.targetValue - game.currentValue)
    let (points, title) = game.pointsAndFeedback(for: difference)
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
    game.currentValue = Int(roundedValue)
  }
  
  func startNewRound() {
    game.startNewRound()
    slider.value = Float(game.currentValue)
    updateLabels()
  }
  
  func updateLabels() {
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    startNewRound()
  }
  
}



