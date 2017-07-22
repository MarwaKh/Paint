//
//  ViewController.swift
//  Paint
//
//  Created by My Computer on 2017-06-24.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var drawingView: DrawingView!
    @IBOutlet weak var eraseButton: UIButton!
    
    var isDrawing = true
    
    var previousColor: CGColor = UIColor.black.cgColor
    
    //    var imagePicked: UIImage!
    
    
    let alert = Alert()
    
    var pictureSelected: Picture!
    var selection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //if the picture is imported from AppPicturesVC
        if selection {
            if let pic = pictureSelected {
                
                if let pictureDecoded = UIImage(data: pic.decodeBase64(encodedData: pic.encodeB64!)) {
                    
                    imageView.image = pictureDecoded
                    imageView.contentMode = .scaleToFill
                    
                    //Convert the uiimageview to a uiimage
                    let img = drawingView.makeImageFromView(view: imageView)
                    //Add the image recently created to the drawing view
                    drawingView.addImageToView(view: drawingView, imagePicked: img!)
                }
            }
            selection = false
        }
    }
    
    //Delete all the view content
    @IBAction func resetBtn(_ sender: UIButton) {
        drawingView.resetView()
        previousColor = drawingView.colorChange(r: 0, g: 0, b: 0)
        drawingView.colorOfStroke = previousColor
    }
    
    //Undo the last drawing action done
    @IBAction func undoBtn(_ sender: UIButton) {
        if(drawingView.positions.count > 0) {
            drawingView.undo()
        }
    }
    
    //Erase
    @IBAction func eraseBtn(_ sender: UIButton) {
        
        if (isDrawing) {
            drawingView.colorOfStroke = drawingView.colorChange(r: 255, g: 255, b: 255)
            eraseButton.setImage(#imageLiteral(resourceName: "brush"), for: .normal)
        } else {
            drawingView.colorOfStroke = previousColor
            eraseButton.setImage(#imageLiteral(resourceName: "eraser"), for: .normal)
        }
        
        isDrawing = !isDrawing
    }
    
    
    @IBAction func pickImageBtn(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Pick an image", message: "Import an image from:", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Application Pictures", style: .default, handler: { [unowned self] (action) in
            self.performSegue(withIdentifier: "AppPicturesSegue", sender: self)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    //save the drawing in the photo library of the device
    @IBAction func saveBtn(_ sender: UIButton) {
        
        //        drawingView.backgroundColor = UIColor.white
        if let image = drawingView.makeImageFromView(view: drawingView) {
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
        //keep track of the current color of the stroke
        previousColor = drawingView.colorOfStroke
        isDrawing = true
        eraseButton.setImage(#imageLiteral(resourceName: "eraser"), for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingsVCSegue" {
            if let destination = segue.destination as? SettingsVC {
                destination.delegate = self
                destination.red = drawingView.red
                destination.blue = drawingView.blue
                destination.green = drawingView.green
                destination.brushSize = drawingView.sizeOfBrush
            }
        }
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, SettingsVCDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            drawingView.addImageToView(view: drawingView, imagePicked: selectedImg)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func settingsVCDidFinish(_ settingsVC: SettingsVC) {
    
        drawingView.colorOfStroke = drawingView.colorChange(r: settingsVC.red*255, g: settingsVC.green*255, b: settingsVC.blue*255)
        drawingView.sizeOfBrush = settingsVC.brushSize
        
        //if the settings are saved, display the eraser icon in the menu and get the last drawing color
        previousColor = drawingView.colorOfStroke
        isDrawing = true
        eraseButton.setImage(#imageLiteral(resourceName: "eraser"), for: .normal)
}

}

