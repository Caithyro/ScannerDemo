//
//  Extensions.swift
//  ScannerDemo
//
//  Created by Дмитрий Куприенко on 22.02.2022.
//

import UIKit
import AVFoundation

extension UIView {
    
    func makeConstraints(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?,
                         bottom: NSLayoutYAxisAnchor?, topMargin: CGFloat, leftMargin: CGFloat,
                         rightMargin: CGFloat, bottomMargin: CGFloat, width: CGFloat, height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topMargin).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftMargin).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightMargin).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomMargin).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0) }
    }
}

extension MainViewController: AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(_ output: AVCapturePhotoOutput,
                            didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        guard let imageData = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        if let scannedResultViewController = main.instantiateViewController(withIdentifier:
                                                                                "ScannedResultViewController")
            as? ScannedResultViewController {
            navigationController?.pushViewController(scannedResultViewController, animated: true)
            scannedResultViewController.capturedImage = previewImage
        }
    }
}
