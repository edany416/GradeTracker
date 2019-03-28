//
//  CourseInputFormViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class CourseInputFormViewController:  InputFormViewController {
    
    @IBOutlet weak var courseNameTextField: GTRoundedTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if inputMode == InputMode.Edit {
            courseNameTextField.text = itemToEdit!.name
        }
        setDelegate(forTextFields: [courseNameTextField])
        courseNameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        courseNameTextField.resignFirstResponder()
    }
    
    @IBAction func textFieldEditted(_ sender: UITextField) {
        setSaveButtonState { () -> Bool in
            let courseName = courseNameTextField.text!
            return !courseName.isEmpty
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueID = segue.identifier, segueID == "Unwind Save"{
            let name = courseNameTextField.text!
            newItem = Course(withName: name)
        }
    }

}
