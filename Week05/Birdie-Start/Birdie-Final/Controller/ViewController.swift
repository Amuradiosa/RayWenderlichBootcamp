//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  lazy var dataSource: [MediaPost] = {
    MediaPostsHandler.shared.getPosts()
    return MediaPostsHandler.shared.mediaPosts
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
  }
  
  private func setUpTableView() {
    tableview.delegate = self
    tableview.dataSource = self
    
    let textPostcell = UINib(nibName: "TextPostTableViewCell", bundle: nil)
    let imagePostcell = UINib(nibName: "ImagePostTableViewCell", bundle: nil)
    
    tableview.register(textPostcell, forCellReuseIdentifier: "TextPostCell")
    tableview.register(imagePostcell, forCellReuseIdentifier: "ImagePostCell")
  }
  
  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
    
  }
  
  @IBAction func didPressCreateImagePostButton(_ sender: Any) {
    
  }
  
  
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
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



