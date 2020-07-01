//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  let viewModel = MediaPostsViewModel()
  
  private(set) var userChosenImage = UIImage() {
    didSet {
      create(.imagePost)
    }
  }
  
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
    create(.textPost)
  }
  
  @IBAction func didPressCreateImagePostButton(_ sender: Any) {
    pickImageAlert()
  }
  
  
  
  func pickImageAlert() {
    let alert = UIAlertController(title: "Post An Image :]", message: "Choose your photo using...", preferredStyle: .alert)
    let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
      self.displayCamera()
    }
    let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
      self.displayLibrary()
    }
    alert.addAction(cameraAction)
    alert.addAction(photoLibraryAction)
    
    present(alert, animated: true)
    
  }
  
  func displayCamera() {
    let sourceType = UIImagePickerController.SourceType.camera
    
    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
      // no permission prompt
      let noPermissionMessage = "looks like Birdie has no access to your camera, please go to settings on your device to permit Gridy accessing your camera"
      
      let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
      switch status {
      case .notDetermined :
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
          if granted {
            self.presentPhoto(withThis: sourceType)
          } else {
            // if permission denied call the function that prompts the user with an alert message
            self.troubleAlert(message: noPermissionMessage)
          }
        }
      case .authorized :
        self.presentPhoto(withThis: sourceType)
      case .denied, .restricted :
        self.troubleAlert(message: noPermissionMessage)
      default:
        // default case to handle all unknown cases.
        troubleAlert(message: "Sincere apologies, it looks like we can't access your camera at this time")
      }
    } else {
      // if the source type isn't available for any reason, prompts the user with an alert message so as to make the user aware that there's something wrong, rather than leaving the user puzzled as to what's happening
      troubleAlert(message: "Sincere apologies, it looks like we can't access your camera at this time")
    }
  }
  
  func displayLibrary() {
    let sourceType = UIImagePickerController.SourceType.photoLibrary
    
    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
      let noPermissionMessage = "looks like Birdie has no access to your library, please go to settings on your device to permit Gridy accessing your library"
      
      let status = PHPhotoLibrary.authorizationStatus()
      switch status {
      case .notDetermined :
        PHPhotoLibrary.requestAuthorization { (granted) in
          if granted == .authorized {
            self.presentPhoto(withThis: sourceType)
          } else {
            self.troubleAlert(message: noPermissionMessage)
          }
        }
      case .authorized :
        self.presentPhoto(withThis: sourceType)
      case .denied, .restricted :
        self.troubleAlert(message: noPermissionMessage)
      default:
        troubleAlert(message: "Sincere apologies, it looks like we can't access your photo library at this time")
      }
    } else {
      troubleAlert(message: "Sincere apologies, it looks like we can't access your photo library at this time")
    }
  }
  
  func presentPhoto(withThis sourceType: UIImagePickerController.SourceType) {
    let photoPicker = UIImagePickerController()
    photoPicker.delegate = self
    photoPicker.sourceType = sourceType
    present(photoPicker, animated: true)
  }
  
  // A function to present alert message when permission denied or restricted
  func troubleAlert(message: String?) {
    let alertController = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Got it", style: .cancel)
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
  
  
  func create(_ post: PostKind) {
    var userNameTextField = UITextField()
    
    let alert = UIAlertController(
      title: "Create Post",
      message: "What's up? :]",
      preferredStyle: .alert
    )
    alert.addTextField { (textField) in
      userNameTextField = textField
      textField.placeholder = "Username"
    }
    alert.addTextField { (textField) in
      textField.placeholder = "Text"
    }
    
    
    let okAction = UIAlertAction(
      title: "Ok",
      style: .default)
    { [weak alert] (action) in
      let username = alert?.textFields![0].text
      let textBody = alert?.textFields![1].text
      if post == PostKind.textPost {
        let textPost = TextPost(textBody: textBody, userName: username!, timestamp: Date())
        MediaPostsHandler.shared.addTextPost(textPost: textPost)
        self.updateTableViewInsertion()
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: userNameTextField)
      } else if post == PostKind.imagePost {
        let imagePost = ImagePost(textBody: textBody, userName: username!, timestamp: Date(), image: self.userChosenImage)
        MediaPostsHandler.shared.addImagePost(imagePost: imagePost)
        self.updateTableViewInsertion()
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: userNameTextField)
      }
    }
    
    okAction.isEnabled = false
    NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: userNameTextField, queue: OperationQueue.main) { (notification) in
      okAction.isEnabled = self.validInput(userNameTextField)
    }
    
    let cancelAction = UIAlertAction(
      title: "Cancel",
      style: .cancel
    )
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
  }
  
  func validInput(_ textfieldInput: UITextField) -> Bool {
    if let caption = textfieldInput.text?.trimmingCharacters(in: .whitespaces) {
      return caption.count > 0
    }
    return false
  }
  
  func updateTableViewInsertion() {
    let indexPath = IndexPath(row: 0, section: 0)
    // Doing it this way so that updating tableView can be animated
    tableview.insertRows(at: [indexPath], with: .automatic)
  }
  
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    viewModel.configureTableViewCell(tableView, cellForRowAt: indexPath)
  }
  
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    guard let pickedImage = info[.originalImage] as? UIImage else {
      fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
    }
    userChosenImage = pickedImage
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
}






