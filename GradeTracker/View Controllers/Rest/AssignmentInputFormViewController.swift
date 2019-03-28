//
//  AssignmentInputFormViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit


class AssignmentInputFormViewController: InputFormViewController {
    
    @IBOutlet weak var assignmentNameTextField: GTRoundedTextField!
    @IBOutlet weak var gradeTextField: GTRoundedTextField!
    @IBOutlet weak var weightTextField: GTRoundedTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if inputMode == InputMode.Edit {
            fillTextFields()
        }
        
        setDelegate(forTextFields: [assignmentNameTextField, gradeTextField, weightTextField])
        assignmentNameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        assignmentNameTextField.resignFirstResponder()
    }
    
    
    @IBAction func textFieldEditted(_ sender: UITextField) {
        stripPercentNotation(gradeTextField)
        stripPercentNotation(weightTextField)
        
        setSaveButtonState { () -> Bool in
            let name = assignmentNameTextField.text!
            let grade = gradeTextField.text!
            let weight = weightTextField.text!
            return userInputIsValid(forName: name, gradeRecieved: grade, andWeight: weight)
        }
        
        convertTextFieldToPercentNotation(gradeTextField)
        convertTextFieldToPercentNotation(weightTextField)
        
    }
    
    
    
    private func userInputIsValid(forName name: String, gradeRecieved grade: String, andWeight weight: String ) -> Bool {
        if name.isEmpty {
            return false
        } else if grade.isEmpty || weight.isEmpty {
            return false
        } else if Double(grade) == nil || Double(weight) == nil {
            return false
        }
        return true
    }
    
    private func fillTextFields() {
        if let assignment = itemToEdit as? Assignment {
            assignmentNameTextField.text = assignment.name
            gradeTextField.text = assignment.grade
            weightTextField.text = String(assignment.weight)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueID = segue.identifier, segueID == "Unwind Save"{
            
            stripPercentNotation(gradeTextField)
            stripPercentNotation(weightTextField)
            
            newItem = Assignment(assignmentNameTextField.text!,
                                 grade: Double(gradeTextField.text!)!,
                                 weight: Double(weightTextField.text!)!)
            
            let name = Notification.Name(rawValue: NotificationNames.dataModified)
            NotificationCenter.default.post(name: name, object: nil)
            
        }
    }
    
    private func stripPercentNotation(_ textField: UITextField) {
        guard var userInput = textField.text, !userInput.isEmpty else {
            return
        }
        if let indexOfPercentSymbol = userInput.index(of: "%") {
            userInput.remove(at: indexOfPercentSymbol)
        }
        textField.text = userInput
    }
    
    private func convertTextFieldToPercentNotation(_ textField: UITextField) {
        guard var userInput = textField.text, !userInput.isEmpty else {
            return
        }
        
        if let indexOfPercentSymbol = userInput.index(of: "%") {
            userInput.remove(at: indexOfPercentSymbol)
        }
        if let indexOfDecimalSymbol = userInput.index(of: ".") {
            userInput.remove(at: indexOfDecimalSymbol)
        }
        if Double(userInput) == nil {
            userInput = ""
        } else {
            
            if userInput.count > 5 {
                let indexInvalidDigit = userInput.index(userInput.startIndex, offsetBy: 5)
                userInput.remove(at: indexInvalidDigit)
            }
            
            if userInput.count == 5 {
                let indexOfDecimal = userInput.index(userInput.startIndex, offsetBy: 3)
                userInput.insert(".", at: indexOfDecimal)
            } else if userInput.count > 2 {
                let indexOfDecimal = userInput.index(userInput.startIndex, offsetBy: 2)
                userInput.insert(".", at: indexOfDecimal)
            }
            
            userInput += "%"
        }
        
        textField.text = userInput
        
        let cursorOffset = userInput.count
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: cursorOffset-1) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }


}
