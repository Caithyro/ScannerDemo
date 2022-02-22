//
//  ViewController.swift
//  ScannerDemo
//
//  Created by Дмитрий Куприенко on 22.02.2022.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    private var capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "capturePhotoNormal")?.withRenderingMode(.alwaysOriginal),
                        for: .normal)
        button.setImage(UIImage(named: "capturePhotoPressed")?.withRenderingMode(.alwaysOriginal),
                        for: .highlighted)
        button.addTarget(self, action: #selector(handleCapturedPhoto),
                         for: .touchUpInside)
        return button
    }()
    
    private let photoOutput = AVCapturePhotoOutput()
    private let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openCamera()
    }
    
    //MARK: - Private
    
    private func openCamera() {
        
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch let error {
                print("Can't set input device with error: \(error)")
            }
            
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            
            let cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            cameraLayer.frame = self.mainView.frame
            cameraLayer.videoGravity = .resizeAspectFill
            self.mainView.layer.addSublayer(cameraLayer)
            captureSession.startRunning()
            self.setupUI()
        }
    }
    
    private func setupUI() {
        
        mainStackView.addSubview(capturePhotoButton)
        capturePhotoButton.makeConstraints(top: nil,
                                           left: nil,
                                           right: nil,
                                           bottom: mainStackView.safeAreaLayoutGuide.bottomAnchor,
                                           topMargin: 0,
                                           leftMargin: 0,
                                           rightMargin: 0,
                                           bottomMargin: 15,
                                           width: 130,
                                           height: 130)
        capturePhotoButton.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
    }
    
    @objc private func handleCapturedPhoto() {
        
        let photoSettings = AVCapturePhotoSettings()
        
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
}
