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
  
  let captureSession = AVCaptureSession()
  var previewLayer: AVCaptureVideoPreviewLayer!
  var activeInput: AVCaptureDeviceInput!
  let imageOutput = AVCapturePhotoOutput()
  
  let videoQueue = DispatchQueue(label: "com.doug-harper.video", qos: .userInitiated)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupCaptureSession()
    setUpPreview()
    startSession()
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Setup Capture Session & Preview
  func setupCaptureSession() {
    // TODO: check this preset - could be High instead of Photo
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    let camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    do {
      let input = try AVCaptureDeviceInput(device: camera)
      if captureSession.canAddInput(input) {
        captureSession.addInput(input)
        activeInput = input
      }
    } catch {
      print("Error setting up device input: \(error.localizedDescription)")
    }
    // TODO: Check on this one!
    imageOutput.isHighResolutionCaptureEnabled = true
    
    if captureSession.canAddOutput(imageOutput) {
      captureSession.addOutput(imageOutput)
    }
  }
  
  func setUpPreview() {
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = cameraPreview.bounds
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    cameraPreview.layer.addSublayer(previewLayer)
  }
  
  func startSession() {
    if !captureSession.isRunning {
      videoQueue.async {
        self.captureSession.startRunning()
      }
    }
  }
  
  func stopRunning() {
    if captureSession.isRunning {
      videoQueue.async {
        self.captureSession.stopRunning()
      }
    }
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

