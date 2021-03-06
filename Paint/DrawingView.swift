//
//  DrawingView.swift
//  Paint
//
//  Created by My Computer on 2017-07-07.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class DrawingView: PaintView {
    
    var isDrawing = false
    var lastPoint : CGPoint!
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var sizeOfBrush: CGFloat = 7.0
    var brushOpacity: CGFloat = 1.0
    
    var colorOfStroke : CGColor = UIColor.black.cgColor
    var strokes = [Stroke]()
    var strokeDict = [Int:Array<Stroke>]()
    var i = 0
    var positions = [Int]()
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else {return}
        isDrawing = true
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        positions.append(strokes.count)

        lastPoint = currentPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        isDrawing = true
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        saveStroke(startPoint: lastPoint, endPoint: currentPoint, color: colorOfStroke, size: sizeOfBrush, opacity: brushOpacity)
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        isDrawing = false
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        saveStroke(startPoint: lastPoint, endPoint: currentPoint, color: colorOfStroke, size: sizeOfBrush, opacity: brushOpacity)
        
        lastPoint = nil
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setBlendMode(.normal)
        context?.setLineCap(.round)
        
        for stroke in strokes {
            context?.beginPath()
            context?.move(to: stroke.startPoint)
            context?.addLine(to: stroke.endPoint)
            context?.setStrokeColor(stroke.color)
            context?.setLineWidth(stroke.size)
            context?.strokePath()
        }
    }
    
    private func saveStroke(startPoint: CGPoint, endPoint: CGPoint, color: CGColor, size: CGFloat, opacity: CGFloat){
        let stroke = Stroke(startPoint: startPoint, endPoint: endPoint, color: color, size: size, opacity: opacity)
        strokes.append(stroke)
        
        setNeedsDisplay()
    }
    
    
    func colorChange(r: CGFloat, g: CGFloat, b: CGFloat, opacity: CGFloat) -> CGColor {
        red = r/255
        green = g/255
        blue = b/255
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: opacity).cgColor
    }
    
    func resetView() {
        strokes = []
        
        setNeedsDisplay()
    }
    
    
    func undo() {
        if (strokes.count > positions.last!) {
        for _:Int in positions.last!..<(strokes.count) {
            strokes.removeLast()
        }
        
        positions.removeLast()
        setNeedsDisplay()
        } else {
            return
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
    
    
    func addImageToView(view:UIView, imagePicked: UIImage) {
        resetView()
        
        UIGraphicsBeginImageContext(view.bounds.size)
        
        imagePicked.draw(in: view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
       
        view.backgroundColor = UIColor(patternImage: image)
    }
}
