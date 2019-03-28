//
//  Gradeable.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

protocol Gradeable {
    func associatedAssignments() -> [Assignment]
    func updateGrade()
}
