//
//  ViewController.swift
//  Camera
//
//  Created by Giles Van Gruisen on 12/5/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

  let captureSession = AVCaptureSession()
  var captureDevice : AVCaptureDevice?

  override func viewDidLoad() {
    super.viewDidLoad()

    captureSession.sessionPreset = AVCaptureSessionPresetLow

    let devices = AVCaptureDevice.devices()

    // Loop through all the capture devices on this phone
    for device in devices {
      // Make sure this particular device supports video
      if (device.hasMediaType(AVMediaTypeVideo)) {
        // Finally check the position and confirm we've got the back camera
        if(device.position == AVCaptureDevicePosition.Back) {
          captureDevice = device as? AVCaptureDevice
        }
      }
    }

    do {
      try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
      captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    } catch _ {

    }

    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspect
    previewLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width / 2, self.view.bounds.size.height)
    let replicatorInstances = 2

    let replicatorLayer = CAReplicatorLayer()
    replicatorLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width / 2, self.view.bounds.size.height)
    replicatorLayer.instanceCount = replicatorInstances
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.view.bounds.size.width / 2, 0.0, 0.0)

    replicatorLayer.addSublayer(previewLayer)
    view.layer.addSublayer(replicatorLayer)

    captureSession.startRunning()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

}

