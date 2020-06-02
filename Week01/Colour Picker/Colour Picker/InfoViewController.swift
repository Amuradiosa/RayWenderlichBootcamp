//
//  InfoViewController.swift
//  Colour Picker
//
//  Created by Ahmad Murad on 02/06/2020.
//  Copyright © 2020 Ahmad Murad. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    loadWikipediaPage()
    }
  
  @IBAction func closeButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  func loadWikipediaPage() {
    guard let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") else { return }
    
    let urlRequest = URLRequest(url: url)
    webView.load(urlRequest)
  }
}
