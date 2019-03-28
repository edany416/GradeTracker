//
//  AddEditFoundationViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

enum InputMode {
    case Add
    case Edit
}

class InputFormViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var leftNavBarIconView: CancelIcon!
    @IBOutlet private weak var rightNavBarIconView: SaveIcon!
    
    private(set) var inputMode: InputMode!
    
    var saveButtonIsEnabled: Bool {
        get {
            return rightNavBarIconView.isUserInteractionEnabled
        }
    }
    var itemToEdit: Displayable?
    var newItem: Displayable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputMode = (itemToEdit == nil) ? InputMode.Add : InputMode.Edit
        setupWith(InputMode: inputMode)
    }
    
    @objc private func leftNavBarViewTapped(_ sender: UIView) {
        self.performSegue(withIdentifier: "Unwind Cancel", sender: self)
    }
    
    @objc private func rightNavBarViewTapped(_ sender: UIView) {
        performUnwindSaveSegue()
    }
    
    func setSaveButtonState(FromInputStatus shouldEnable: () -> Bool) {
        if shouldEnable() {
            rightNavBarIconView.set(toButtonState: .Enabled)
        } else {
            rightNavBarIconView.set(toButtonState: .Disabled)
        }
    }
    
    func setDelegate(forTextFields textFields: [UITextField]) {
        for textField in textFields {
            textField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if rightNavBarIconView.isUserInteractionEnabled {
            performUnwindSaveSegue()
        } else {
            textField.becomeFirstResponder()
            UserErrorAlerts.missingInfoError(inViewController: self)
        }
        return true
    }

    private func performUnwindSaveSegue() {
        self.performSegue(withIdentifier: "Unwind Save", sender: self)
    }
    
    private func setupWith(InputMode mode: InputMode) {
        
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftNavBarViewTapped(_:)))
        leftNavBarIconView.addGestureRecognizer(leftTapGesture)
        
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightNavBarViewTapped(_:)))
        rightNavBarIconView.addGestureRecognizer(rightTapGesture)
        
        switch mode {
        case .Add:
            rightNavBarIconView.set(toButtonState: .Disabled)
        case .Edit:
            rightNavBarIconView.set(toButtonState: .Enabled)
        }
    }
}
