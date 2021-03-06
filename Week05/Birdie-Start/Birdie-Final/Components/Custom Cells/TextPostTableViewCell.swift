//
//  TextPostTableViewCell.swift
//  Birdie-Final
//
//  Created by Ahmad Murad on 29/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class TextPostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var postTextLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func populateCell(with textPost: TextPost) {
    userNameLabel.text = textPost.userName
    dateLabel.text = textPost.timestamp.string
    postTextLabel.text = textPost.textBody
  }
  
}
