/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
  var game = BullsEyeGame(gameMaxValue: 255)

  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  @IBAction func aSliderMoved(sender: UISlider) {
    let roundedValue = sender.value.rounded()
    if sender.tag == 0 {
      game.currentValue.r = Int(roundedValue)
      redLabel.text = Int(roundedValue).description
    } else if sender.tag == 1 {
      game.currentValue.g = Int(roundedValue)
      greenLabel.text = Int(roundedValue).description
    } else if sender.tag == 2 {
      game.currentValue.b = Int(roundedValue)
      blueLabel.text = Int(roundedValue).description
    }
    guessLabel.backgroundColor = UIColor.init(rgbStruct: game.currentValue)
  }
  
  @IBAction func showAlert(sender: AnyObject) {
    let difference = Int(game.currentValue.difference(target: game.targetValue) * 100)
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
  
  @IBAction func startOver(sender: AnyObject) {
    game.startNewGame()
    startNewRound()
  }
  
  func startNewRound() {
    game.startNewRound()
    redSlider.value = Float(game.currentValue.r)
    greenSlider.value = Float(game.currentValue.g)
    blueSlider.value = Float(game.currentValue.b)
    updateView()
  }
  
  func updateView() {
    targetLabel.backgroundColor = UIColor.init(rgbStruct: game.targetValue)
    guessLabel.backgroundColor = UIColor.white
    redLabel.text = game.currentValue.r.description
    greenLabel.text = game.currentValue.g.description
    blueLabel.text = game.currentValue.b.description
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame()
    updateView()
  }

}

