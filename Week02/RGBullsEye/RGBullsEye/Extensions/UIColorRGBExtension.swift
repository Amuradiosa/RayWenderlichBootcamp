//
//  UIColorRGBExtension.swift
//  RGBullsEye
//
//  Created by Ahmad Murad on 09/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(rgbStruct rgb: RGB) {
    let r = CGFloat(rgb.r) / 255.0
    let g = CGFloat(rgb.g) / 255.0
    let b = CGFloat(rgb.b) / 255.0
    self.init(red: r, green: g, blue: b, alpha:1.0)
  }
}
