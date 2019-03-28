//
//  GTRoundedTextField.swift
//  GradeTracker
//
//  Created by edan yachdav on 8/9/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class GTRoundedTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    private func setupTextField() {
        
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.red.cgColor
    }

}
