//
//  CameraService.swift
//  DanceAppPrototype
//
//  Created by Rohan Kumar on 6/21/23.
//

import Foundation
import AVFoundation

class CameraService {
    
    var session: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    private func checkPermissions(errorHandler: @escaping (Error?) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] permissionWasGranted in
                if !permissionWasGranted { return }
                
                DispatchQueue.main.async {
                    self?.setupCamera(errorHandler: errorHandler)
                }
            }
        case .authorized:
            setupCamera(errorHandler: errorHandler)
        case .restricted, .denied:
            break
        @unknown default:
            break
        }
    }
    
    private func setupCamera(errorHandler: @escaping (Error?) -> ()) {
        let session = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(self.output) {
                    session.addOutput(self.output)
                }
                
                self.previewLayer.videoGravity = .resizeAspectFill
                self.previewLayer.session = session
                session.startRunning()
                self.session = session
                
                
            } catch {
                errorHandler(error)
            }
        }
    }
    
    func start(delegate: AVCapturePhotoCaptureDelegate, errorHandler: @escaping (Error?) -> ()) {
        self.delegate = delegate
        self.checkPermissions(errorHandler: errorHandler)
    }
    
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        self.output.capturePhoto(with: settings, delegate: self.delegate!)
    }
}
