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

  @IBAction func setFlashMode(_ sender: Any) {
  }

  @IBAction func switchCameras(_ sender: UIButton) {
  }
  
  @IBAction func capturePhoto(_ sender: UIButton) {
  }
  
}

