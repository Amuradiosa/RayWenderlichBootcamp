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
  
  @IBOutlet weak var sliderGuessTextField: UITextField!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
  }

//  func textFieldDidBeginEditing(_ textField: UITextField) {
//    guard let text = Int(sliderGuessTextField.text!) else { return }
//    game.currentValue = text
//    sliderGuessTextField.backgroundColor = UIColor.blue.withAlphaComponent(CGFloat(difference)/100.0)
//  }
  
  @IBAction func tapped(_ sender: Any) {
    view.endEditing(true)
  }
  
  @IBAction func showAlert() {
    var pointsAndTitle: (points: Int, title: String)
    var message: String
    
    if let text = Int(sliderGuessTextField.text!), 0...100 ~= text   {
      game.currentValue = text
      pointsAndTitle = game.pointsAndFeedback(forThis: difference)
      message = "You scored \(pointsAndTitle.points) points"
    } else {
      message = "Invalid input"
    }
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      self.startNewRound()
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  func startNewRound() {
    game.startNewRound()
    slider.value = Float(game.targetValue)
    updateView()
  }
  
  func updateView() {
    sliderGuessTextField.text = ""
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    startNewRound()
  }
  
}



