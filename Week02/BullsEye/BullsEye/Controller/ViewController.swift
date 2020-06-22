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
  var difference: Int {
    abs(game.targetValue - game.currentValue)
  }
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(difference)/100.0)
  }

  @IBAction func showAlert() {
    let (points, title) = game.pointsAndFeedback(forThis: difference)
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
    slider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(difference)/100.0)
  }
  
  func startNewRound() {
    game.startNewRound()
    slider.value = Float(game.currentValue)
    updateView()
  }
  
  func updateView() {
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(difference)/100.0)
  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    // you could've called this function internal in bullseyegame model
    startNewRound()
  }
  
}



