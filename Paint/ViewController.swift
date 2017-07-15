//
//  ViewController.swift
//  Paint
//
//  Created by My Computer on 2017-06-24.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var drawingView: DrawingView!
    
    let alert = Alert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Delete all the view content
    @IBAction func resetBtn(_ sender: UIButton) {
        drawingView.resetView()
    }
    
    //save the drawing in the photo library of the device
    @IBAction func saveBtn(_ sender: UIButton) {
        
        if let image = makeImageFromView(view: drawingView) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            alert.showAlert(title: "", message: "Your drawing has been successfully saved.", fromVC: self)
        }
    }
    
    //everytime a color is clicked, the stroke color is changed to that color
    @IBAction func colorBtn(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            drawingView.colorOfStroke = drawingView.colorChange(r: 255, g: 255, b: 0)
        case 1:
            drawingView.colorOfStroke = drawingView.colorChange(r: 255, g: 128, b: 0)
        case 2:
            drawingView.colorOfStroke = drawingView.colorChange(r: 128, g: 255, b: 0)
        case 3:
            drawingView.colorOfStroke = drawingView.colorChange(r: 64, g: 128, b: 0)
        case 4:
            drawingView.colorOfStroke = drawingView.colorChange(r: 0, g: 255, b: 255)
        case 5:
            drawingView.colorOfStroke = drawingView.colorChange(r: 0, g: 0, b: 255)
        case 6:
            drawingView.colorOfStroke = drawingView.colorChange(r: 128, g: 0, b: 255)
        case 7:
            drawingView.colorOfStroke = drawingView.colorChange(r: 255, g: 0, b: 0)
        case 8:
            drawingView.colorOfStroke = drawingView.colorChange(r: 128, g: 64, b: 0)
        case 9:
            drawingView.colorOfStroke = drawingView.colorChange(r: 0, g: 0, b: 0)
        case 10:
            drawingView.colorOfStroke = drawingView.colorChange(r: 169, g: 169, b: 169)
        default:
            drawingView.colorOfStroke = drawingView.colorChange(r: 0, g: 0, b: 0)
        }
        
    }
    
    //convert a view into an image
    func makeImageFromView(view:UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

