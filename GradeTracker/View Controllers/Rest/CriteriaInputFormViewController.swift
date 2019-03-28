//
//  AddEditCriteriaViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class CriteriaInputFormViewController: InputFormViewController {

    @IBOutlet weak var criteriaNameTextField: GTRoundedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if inputMode == InputMode.Edit {
            criteriaNameTextField.text = itemToEdit?.name
        }
        setDelegate(forTextFields: [criteriaNameTextField])
        criteriaNameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        criteriaNameTextField.resignFirstResponder()
    }

    @IBAction func nameFieldEdited(_ sender: UITextField) {
        setSaveButtonState { () -> Bool in
            let criteriaName = criteriaNameTextField.text!
            return !criteriaName.isEmpty
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueID = segue.identifier, segueID == "Unwind Save"{
            let name = criteriaNameTextField.text!
            newItem = GradingCriteria(name)
        }
    }

}
