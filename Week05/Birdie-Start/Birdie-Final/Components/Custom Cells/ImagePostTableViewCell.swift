//
//  ImagePostTableViewCell.swift
//  Birdie-Final
//
//  Created by Ahmad Murad on 29/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var postTextLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func populateCell(with imagePost: ImagePost) {
    userNameLabel.text = imagePost.userName
    dateLabel.text = imagePost.timestamp.string
    postTextLabel.text = imagePost.textBody
    postImageView.image = imagePost.image
  }
  
}
