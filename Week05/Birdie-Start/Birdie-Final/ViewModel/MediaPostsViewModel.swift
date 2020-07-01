//
//  MediaPostsViewModel.swift
//  Birdie-Final
//
//  Created by Ahmad Murad on 01/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class MediaPostsViewModel {
  
  var dataSource: [MediaPost] {
    return MediaPostsHandler.shared.mediaPosts
  }
  
  init() {}
  
}

extension MediaPostsViewModel {
  
  func configureTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let textPost = dataSource[indexPath.row] as? TextPost {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCell", for: indexPath) as! TextPostTableViewCell
      cell.populateCell(textPost.userName, textPost.timestamp, textPost.textBody)
      return cell
    } else if let imagePost = dataSource[indexPath.row] as? ImagePost {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ImagePostCell", for: indexPath) as! ImagePostTableViewCell
      cell.populateCell(imagePost.userName, imagePost.timestamp, imagePost.textBody, imagePost.image)
      return cell
    }
    return UITableViewCell()
  }
}
