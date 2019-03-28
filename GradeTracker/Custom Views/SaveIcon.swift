//
//  SaveIcon.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

enum SaveButtonState {
    case Enabled
    case Disabled
}

class SaveIcon: UIView {

    private var iconColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func set(toButtonState state: SaveButtonState) {
        switch state {
        case .Enabled:
            iconColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            self.isUserInteractionEnabled = true
        case .Disabled:
            iconColor = UIColor.gray
            self.isUserInteractionEnabled = false
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: centerOfBounds(), radius: halfWidth(), startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
        let backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        backgroundColor.setFill()
        circlePath.fill()
        
        let shortStart = CGPoint(x: 0.25*maxX(), y: 0.50*maxY())
        let shortEnd = CGPoint(x: 0.5*maxX(), y: 0.75*maxY())
        let longStart = CGPoint(x: 0.45*maxX(), y: 0.75*maxY())
        let longEnd = CGPoint(x: 0.79*maxX(), y: 0.21*maxY())
        
        let shortLine = UIBezierPath()
        shortLine.lineWidth = 3.0
        shortLine.move(to: shortStart)
        shortLine.addLine(to: shortEnd)
        
        iconColor.setStroke()
        shortLine.stroke()
        
        let longLine = UIBezierPath()
        longLine.lineWidth = 3.0
        longLine.move(to: longStart)
        longLine.addLine(to: longEnd)
        
        iconColor.setStroke()
        longLine.stroke()
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
