//
//  CancelIcon.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class CancelIcon: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false      
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: centerOfBounds(),
                          radius: self.bounds.width/2,
                          startAngle: 0,
                          endAngle: 2*CGFloat.pi,
                          clockwise: false)
        let backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        backgroundColor.setFill()
        circlePath.fill()
        
        let topLeft = CGPoint(x: 0.25*maxX(), y: 0.25*maxY())
        let topRight = CGPoint(x: 0.75*maxX(), y: 0.25*maxY())
        let bottomLeft = CGPoint(x: 0.25*maxX(), y: 0.75*maxY())
        let bottomRight = CGPoint(x: 0.75*maxX(), y: 0.75*maxY())
        
        let downSlopeLine = UIBezierPath()
        downSlopeLine.lineWidth = 3.0
        downSlopeLine.move(to: topLeft)
        downSlopeLine.addLine(to: bottomRight)
        
        UIColor.red.setStroke()
        downSlopeLine.stroke()
        
        let upSlopeLine = UIBezierPath()
        upSlopeLine.lineWidth = 3.0
        upSlopeLine.move(to: bottomLeft)
        upSlopeLine.addLine(to: topRight)
        
        UIColor.red.setStroke()
        upSlopeLine.stroke()
        
        
    }
    
    private func maxX() -> CGFloat {
        return self.bounds.maxX
    }
    
    private func maxY() -> CGFloat {
        return self.bounds.maxY
    }
    
    private func centerOfBounds() -> CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    private func halfWidth() -> CGFloat {
        return self.bounds.width/2
    }


}
