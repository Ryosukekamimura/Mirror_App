//
//  CameraController.swift
//  Tracking_User_Face
//
//  Created by 神村亮佑 on 2020/08/31.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: NSObject{
    
    var captureSession: AVCaptureSession?
    var frontCamera: AVCaptureDevice?
    var frontCameraDevice: AVCaptureDeviceInput?
    var frontCameraInput: AVCaptureDeviceInput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    // enumでエラー拾えるようにしておく
    enum CameraControllerError: Swift.Error{
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
    }
    
    
    
    
    func prepare(completionHandler: @escaping (Error?) -> Void){
        
        // To manage capture activity and coordinates he flow of data from input and output devices.
        func createCaptureSession(){
            self.captureSession = AVCaptureSession()
        }
        
        
        func configureCaptureDevices() throws {
            // AVCapture Device Setting
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
            self.frontCamera = camera
            
            // exclusive access
            try camera?.lockForConfiguration()
            
            // relinquishes exclusive access
            camera?.unlockForConfiguration()
        }
        
        
        
        
        func configureDeviceInputs() throws {
            
            // catch captureSessionIsMissing
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }

            if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput.init(device: frontCamera)

                //whether a given input can be added to the session. then add a given input
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!)}
                else { throw CameraControllerError.inputsAreInvalid }

            }
            // frontCameraに代入できないからfrontCameraは使えない可能性が高いというエラーをはく
            else { throw CameraControllerError.noCamerasAvailable }

            // capture running!
            captureSession.startRunning()
        }
           
        
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
            }
            catch {
                DispatchQueue.main.async{
                    completionHandler(error)
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }
    
    
    func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }

        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = view.frame
    }
    
    func stopVideoRunning() throws {
        guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
        
        captureSession.stopRunning()
    }
}
