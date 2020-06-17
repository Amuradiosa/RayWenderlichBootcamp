/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController{

  @IBOutlet weak var view1: CryptoView!
  @IBOutlet weak var view2: CryptoView!
  @IBOutlet weak var view3: CryptoView!
  @IBOutlet weak var mostFallingView: CryptoView!
  @IBOutlet weak var mostRisingView: CryptoView!

  @IBOutlet weak var mostFallingHeading: UILabel!
  @IBOutlet weak var mostRisingHeading: UILabel!
  @IBOutlet weak var mostFallingTextLabel: UILabel!
  @IBOutlet weak var mostRisingTextLabel: UILabel!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  let cryptoData = DataGenerator.shared.generateData()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setMostFallingViewData()
    setMostRisingViewData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  
  private func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view3TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  private func setView1Data() {
    view1TextLabel.text = cryptoData?
      .map { $0.name }
      .joined(separator: ", ")
  }
  
  private func setView2Data() {
    view2TextLabel.text = cryptoData?
      .filter { $0.currentValue > $0.previousValue }
      .map { $0.name }
      .joined(separator: ", ")
  }
  
  private func setView3Data() {
    view3TextLabel.text = cryptoData?
      .filter { $0.currentValue < $0.previousValue  }
      .map { $0.name }
      .joined(separator: ", ")
  }
  
  private func setMostFallingViewData() {
    mostFallingTextLabel.text = cryptoData?
      .filter { $0.trend == .falling }
      .map { $0.valueRise }
      .min()?.description
  }
  
  private func setMostRisingViewData() {
    mostRisingTextLabel.text = cryptoData?
      .filter { $0.trend == .rising }
      .map { $0.valueRise }
      .max()?.description
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    switch themeSwitch.isOn {
    case true:
      ThemeManager.shared.set(theme: WinterTheme())
    case false:
      ThemeManager.shared.set(theme: LightTheme())
    }
  }
  
}

extension HomeViewController: Themable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    let views = [view1, view2, view3, mostFallingView, mostRisingView]
    let labels = [view1TextLabel, view2TextLabel, view3TextLabel, mostFallingTextLabel, mostRisingTextLabel, headingLabel, mostFallingHeading, mostRisingHeading]
    UIView.animate(withDuration: 0.3) {
      views.forEach {
        $0!.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
        $0!.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
      }
      labels.forEach {
        $0!.textColor = ThemeManager.shared.currentTheme?.textColor
      }

      self.view.backgroundColor = ThemeManager.shared.currentTheme?.backgroundColor
      self.navigationController?.navigationBar.barTintColor =  ThemeManager.shared.currentTheme?.widgetBackgroundColor
    }
  }
  
}
