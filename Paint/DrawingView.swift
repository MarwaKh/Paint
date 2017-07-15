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
    
    var colorOfStroke : CGColor = UIColor.black.cgColor
    var strokes = [Stroke]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else {return}
        isDrawing = true
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        lastPoint = currentPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        isDrawing = true
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        saveStroke(startPoint: lastPoint, endPoint: currentPoint, color: colorOfStroke)

        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        isDrawing = false
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        saveStroke(startPoint: lastPoint, endPoint: currentPoint, color: colorOfStroke)

        lastPoint = nil
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(8)
        context?.setBlendMode(.normal)
        context?.setLineCap(.round)
        
        for stroke in strokes {
            context?.beginPath()
            context?.move(to: stroke.startPoint)
            context?.addLine(to: stroke.endPoint)
            context?.setStrokeColor(stroke.color)
            context?.strokePath()
        }
    }
    
    private func saveStroke(startPoint: CGPoint, endPoint: CGPoint, color: CGColor){
        let stroke = Stroke(startPoint: startPoint, endPoint: endPoint, color: color)
        strokes.append(stroke)
        
        setNeedsDisplay()
    }
    
    
    func colorChange(r: CGFloat, g: CGFloat, b: CGFloat) -> CGColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0).cgColor
    }
    
    func resetView() {
        strokes = []

        colorOfStroke = colorChange(r: 0, g: 0, b: 0)
        
        setNeedsDisplay()
    }
    
}
