//
//  TakePhotoViewController.swift
//  nearbuy
//
//  Created by Jon Choi on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import AVFoundation

class TakePhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var previewView: UIView!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = dispatch_queue_create("com.marcusellison.nearbuy.sessionqueue", nil)
    
    private let previewLayer: AVCaptureVideoPreviewLayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewView.layer.addSublayer(previewLayer)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        super.init(coder: aDecoder)
        
        dispatch_async(sessionQueue, { () -> Void in
            let inputDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            var error: NSError?
            let input = AVCaptureDeviceInput(device: inputDevice, error: &error)
            // error checking
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
            } // else more error handling
            
            self.captureSession.startRunning()
            
        })
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer.frame = previewView.bounds
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func takePhoto(sender: AnyObject) {

    }
    
    @IBAction func uploadPhoto(sender: AnyObject) {
        

    }
    

}
