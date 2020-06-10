//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
  
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
    configureTextField()
  }
  
  // MARK: text field delegate method
  func configureTextField() {
    sliderGuessTextField.delegate = self
    sliderGuessTextField.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
    sliderGuessTextField.backgroundColor = UIColor.blue.withAlphaComponent(CGFloat(difference)/100.0)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if (textField.text!.count >= 3 && !string.isEmpty) {
      return false
    }
    
    let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
    return (string.rangeOfCharacter(from: invalidCharacters) == nil)
  }
  
  @objc func editingChanged(_ textField: UITextField) {
    if let num = Int(textField.text!) {
      textField.text = "\(num)"
      game.currentValue = num
    } else {
      textField.text = ""
    }
    sliderGuessTextField.backgroundColor = UIColor.blue.withAlphaComponent(CGFloat(difference)/100.0)
  }
  
  @IBAction func tapped(_ sender: Any) {
    view.endEditing(true)
  }
  
  @IBAction func showAlert() {
    var pointsAndTitle: (points: Int, title: String)
    var message: String
    var title: String
    
    if let text = Int(sliderGuessTextField.text!), 0...100 ~= text   {
      pointsAndTitle = game.pointsAndFeedback(forThis: difference)
      message = "You scored \(pointsAndTitle.points) points"
      title = pointsAndTitle.title
    } else {
      message = "Invalid input"
      title = ""
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



