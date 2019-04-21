//
//  ViewController.swift
//  MLapp
//
//  Created by Deniz Gelir on 4/21/19.
//  Copyright © 2019 Deniz Gelir. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate{

    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }

        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoOutput"))
        captureSession.addOutput(dataOutput)


    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let model = try?  VNCoreMLModel(for:MobileNet().model) else {return}
        
        let request = VNCoreMLRequest (model: model) { (finishedReq , err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
            
            guard let firstObservation = results.first else {return}
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "Object: \(firstObservation.identifier)"
                self.confidenceLabel.text = "Confidence: %\(firstObservation.confidence * 100)"
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    
    
}

