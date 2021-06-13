//
//  PhotoViewController.swift
//  MCHProject
//
//  Created by Савченко Максим Олегович on 12.06.2021.
//

import UIKit
import AVFoundation

final class PhotoViewController: UIViewController {
    
    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var photoView: UIView!
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var capruteDevice: AVCaptureDevice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForScanning()
    }
    
    func prepareForScanning() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        capruteDevice = videoCaptureDevice
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = photoView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        photoView.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    @IBAction func tapToGallery(_ sender: Any) {
        
    }
    
    
    @IBAction func tapToHint(_ sender: Any) {
        
    }
    
    
    @IBAction func tapToMakePhoto(_ sender: Any) {
        
    }
    
}
