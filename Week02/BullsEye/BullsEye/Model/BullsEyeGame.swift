//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Ahmad Murad on 06/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

struct BullsEyeGame {
  var currentValue = 0
  var targetValue = 0
  var score = 0
  var round = 0
  
  mutating func pointsAndFeedback() -> (Int, String) {
    let difference = abs(targetValue - currentValue)
    var points = 100 - difference
    
    score += points
    
    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }
    return (points, title)
  }
  
  mutating func startNewRound() {
    round += 1
    targetValue = Int.random(in: 1...100)
    currentValue = 50
  }
  
  mutating func startNewGame() {
    score = 0
    round = 0
  }
  
}
