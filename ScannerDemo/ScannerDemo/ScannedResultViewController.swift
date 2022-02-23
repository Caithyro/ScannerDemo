//
//  SecondViewController.swift
//  ScannerDemo
//
//  Created by Дмитрий Куприенко on 22.02.2022.
//

import UIKit
import GPUImage

class ScannedResultViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var grayscaleButton: UIButton!
    @IBOutlet weak var whiteAndBlackButton: UIButton!
    
    var capturedImage: UIImage?
    var grayscaleButtonPressed: Bool = false
    var whiteAndBlackButtonPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func grayscaleButtonPressed(_ sender: Any) {
        
        if grayscaleButtonPressed == false {
            setGrayscaleImage()
        } else {
            setOriginalImage(whatButtonHasBeenPressed: 0)
        }
        
    }
    
    @IBAction func whiteAndBlackButtonPressed(_ sender: Any) {
        
        if whiteAndBlackButtonPressed == false {
            setPixelatedImage()
        } else {
            setOriginalImage(whatButtonHasBeenPressed: 1)
        }
    }
    
    //MARK: - Private
    
    private func setGrayscaleImage() {
        
        let grayImage = OpenCVWrapper.toGray(mainImageView.image!)
        mainImageView.image = grayImage
        grayscaleButtonPressed = true
        grayscaleButton.setImage(UIImage(named: "grayscalePressed"),
                                 for: .normal)
    }
    
    private func setPixelatedImage() {
        
        let targetImage = mainImageView.image!
        let filter = Pixellate()
        let filteredImage = targetImage.filterWithOperation(filter)
        mainImageView.image = filteredImage
        whiteAndBlackButtonPressed = true
        whiteAndBlackButton.setImage(UIImage(named: "whiteAndBlackPressed"),
                                     for: .normal)
    }
    
    private func setOriginalImage(whatButtonHasBeenPressed: Int) {
        
        if whatButtonHasBeenPressed == 0 {
            grayscaleButtonPressed = false
            grayscaleButton.setImage(UIImage(named: "grayscaleNormal"),
                                     for: .normal)
        } else {
            whiteAndBlackButtonPressed = false
            whiteAndBlackButton.setImage(UIImage(named: "whiteAndBlackNormal"),
                                         for: .normal)
        }
        mainImageView.image = capturedImage!
    }
    
    private func setupUI() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self, action: #selector(backAction))
        self.title = "Filters"
        self.navigationItem.setHidesBackButton(true, animated: false)
        mainImageView.image = capturedImage!
        self.mainImageView.layer.cornerRadius = 15
    }
    
    @objc private func backAction() {
        
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
