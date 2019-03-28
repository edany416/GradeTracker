//
//  BaseVCBackDrop.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/26/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class BaseVCBackDropView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        // Set up label that will instruct user to tap + to add an item
        let emptyTableLabel = UILabel(frame: CGRect.zero)
        emptyTableLabel.text = "Tap the '+' in the upper\nright to add an item."
        emptyTableLabel.textColor = UIColor.lightGray
        emptyTableLabel.textAlignment = .center
        emptyTableLabel.numberOfLines = 2
        self.addSubview(emptyTableLabel)
        
        let xConstraint = NSLayoutConstraint(item: emptyTableLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: emptyTableLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([xConstraint, yConstraint])
    }

}
