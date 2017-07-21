//
//  SettingsVC.swift
//  Paint
//
//  Created by My Computer on 2017-07-21.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

protocol SettingsVCDelegate:class {
    func settingsVCDidFinish(_ settingsVC: SettingsVC)
}

class SettingsVC: UIViewController {

    @IBOutlet weak var settingsImageView: UIImageView!
    
    @IBOutlet weak var brushSizeLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var opacityLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var delegate: SettingsVCDelegate?
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateImage(r: red, g: green, b: blue)
        
        redSlider.value = Float(red)
        redLabel.text = String(Int(redSlider.value * 255))
        
        greenSlider.value = Float(green)
        greenLabel.text = String(Int(greenSlider.value * 255))
        
        blueSlider.value = Float(blue)
        blueLabel.text = String(Int(blueSlider.value * 255))
    }

    @IBAction func saveChangesBtn(_ sender: UIBarButtonItem) {
        
        if delegate != nil {
            delegate?.settingsVCDidFinish(self)
        }
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cancelBtn(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func sizeSlider(_ sender: UISlider) {
    }
    
    @IBAction func redSlider(_ sender: UISlider) {
        
        red = CGFloat(sender.value)
        updateImage(r: red, g: green, b: blue)
        redLabel.text = "\(Int(sender.value * 255))"
    }
    
    @IBAction func greenSlider(_ sender: UISlider) {
        
        green = CGFloat(sender.value)
        updateImage(r: red, g: green, b: blue)
        greenLabel.text = "\(Int(sender.value * 255))"
    }
  
    
    @IBAction func blueSlider(_ sender: UISlider) {
        
        blue = CGFloat(sender.value)
        updateImage(r: red, g: green, b: blue)
        blueLabel.text = "\(Int(sender.value * 255))"
    }
    
    @IBAction func opacitySlider(_ sender: UISlider) {
    }
    
    func updateImage(r:CGFloat, g:CGFloat, b:CGFloat) {
        
        settingsImageView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
   

}
