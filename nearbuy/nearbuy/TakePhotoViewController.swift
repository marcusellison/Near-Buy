//
//  TakePhotoViewController.swift
//  nearbuy
//
//  Created by Marcus J. Ellison on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import AVFoundation

class TakePhotoViewController: UIViewController{

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var capturePhotoView: UIView!
    
    private var photoImage: UIImage?
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = dispatch_queue_create("com.marcusellison.nearbuy.sessionqueue", nil)
    
    private let previewLayer: AVCaptureVideoPreviewLayer
    
    private let stillCameraOutput = AVCaptureStillImageOutput()
    
    private var capturedPhotos: [UIImage] = []
    private var capturedPhotoX: CGFloat = 0
    
    private let outputQueue = dispatch_queue_create("com.marcusellison.nearbuy.outputqueue", nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewView.layer.addSublayer(previewLayer)
        
        nextButton.hidden = true
        
        capturePhotoView.hidden = true
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        super.init(coder: aDecoder)
        
        dispatch_async(sessionQueue, { () -> Void in
            
            let inputDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            var error: NSError?
            let input = AVCaptureDeviceInput(device: inputDevice, error: &error)
            
            if self.captureSession.canAddInput(input) {
                self.captureSession.addInput(input)
            } // else more error handling
            
            
            if self.captureSession.canAddOutput(self.stillCameraOutput) {
                self.captureSession.addOutput(self.stillCameraOutput)
            }
            
            
            
            self.captureSession.startRunning()
            
        })
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //adjust bounds
        previewLayer.frame = previewView.bounds
        
        // adjust aspect ration of preview
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ProductDetail" {
            let takePhotosDetailViewController = segue.destinationViewController as! TakePhotosDetailViewController
            
            takePhotosDetailViewController.productImage = self.photoImage
        }
    }
    
    
    // saving the image
    @IBAction func takePhoto(sender: AnyObject) {
        
        instructionLabel.hidden = true
        nextButton.hidden = false
        capturePhotoView.hidden = false
        
        dispatch_async(outputQueue, { () -> Void in
            let connection = self.stillCameraOutput.connectionWithMediaType(AVMediaTypeVideo)
            
            // update the video orientation to the device one
            connection.videoOrientation = AVCaptureVideoOrientation(rawValue: UIDevice.currentDevice().orientation.rawValue)!
        
            self.stillCameraOutput.captureStillImageAsynchronouslyFromConnection(connection) {
                (imageDataSampleBuffer, error) -> Void in
                
                if error == nil {
                    
                    // if the session preset .Photo is used, or if explicitly set in the device's outputSettings
                    // we get the data already compressed as JPEG
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    
                    // the sample buffer also contains the metadata, in case we want to modify it
                    let metadata:NSDictionary = CMCopyDictionaryOfAttachments(nil, imageDataSampleBuffer, CMAttachmentMode(kCMAttachmentMode_ShouldPropagate)).takeUnretainedValue()
                    
                    println(metadata)
                    
                    if let image = UIImage(data: imageData) {
                        
                        //after image resizing:
                        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.5, 0.5))
                        let hasAlpha = false
                        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
                        
                        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
                        image.drawInRect(CGRect(origin: CGPointZero, size: size))
                        
                        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        
                        println(scaledImage)
                        
                        // set image
                        self.photoImage = scaledImage
                        
                        if self.capturedPhotos.count < 3 {
                            self.capturedPhotos.append(image)
                            
                            for image in self.capturedPhotos {
                                var imageView = UIImageView(frame: CGRectMake(self.capturedPhotoX, 0, 81, 144));
                                    imageView.image = image;
                                    self.capturePhotoView.addSubview(imageView);
                            }
                            
                            self.capturedPhotoX += 120
                        }
                    }
                }
                else {
                    NSLog("error while capturing still image: \(error)")
                }
            }
        })

        
    }
    
    
    

}
