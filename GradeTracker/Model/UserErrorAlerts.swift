//
//  UserErrorAlerts.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/30/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation
import UIKit

struct UserErrorAlerts {
    static func duplicatAdded(withName name: String, on vc: UIViewController) {
        let alert = UIAlertController(title: "Duplicate Added", message: "'\(name)' already exists", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func missingInfoError(inViewController vc: UIViewController) {
        let alert = UIAlertController(title: "Missing Info", message: "Text fields cannot be blank", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
