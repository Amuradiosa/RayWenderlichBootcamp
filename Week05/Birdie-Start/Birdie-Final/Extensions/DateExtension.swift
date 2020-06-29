//
//  DateExtension.swift
//  Birdie-Final
//
//  Created by Ahmad Murad on 29/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

extension Date {
  
  // Get string representation form date
  var string: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_GB")
    formatter.setLocalizedDateFormatFromTemplate("MMMd, HH:mm")
    return formatter.string(from: self)
  }
}
