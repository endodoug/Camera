//
//  ViewController.swift
//  Camera
//
//  Created by doug harper on 11/3/16.
//  Copyright © 2016 Doug Harper. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController {

  @IBOutlet weak var cameraPreview: UIView!
  @IBOutlet weak var thumbnailButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Set Flash
  @IBAction func setFlashMode(_ sender: Any) {
  }

  // MARK: - Switch Cameras
  @IBAction func switchCameras(_ sender: UIButton) {
  }
  
  // MARK: - Capture Photo
  @IBAction func capturePhoto(_ sender: UIButton) {
  }
  
  // MARK: - Helpers
  func savePhotoToLibrary(image: UIImage) {
    let photoLibrary = PHPhotoLibrary.shared()
    photoLibrary.performChanges({
      PHAssetChangeRequest.creationRequestForAsset(from: image)
    }) { (success: Bool, error: Error?) -> Void in
      if success {
        // Set thumbnail
        self.setPhotoThumbnail(image: image)
      } else {
        print("Error writing to photo library: \(error!.localizedDescription)")
      }
    }
  }
  
  func setPhotoThumbnail(image: UIImage) {
    DispatchQueue.main.async() { () -> Void in
      self.thumbnailButton.setBackgroundImage(image, for: UIControlState.normal)
      self.thumbnailButton.layer.borderColor = UIColor.white.cgColor
      self.thumbnailButton.layer.borderWidth = 1.0
    }
  }


  
}

