//
//  GradeFormatter.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

enum GradeStyle {
    case Letter
    case Numerical
}

struct GradeFormatter {
    
    private var internal_formated_grade: String!
    var formatedGrade: String {
        get {
            return internal_formated_grade
        }
    }
    
    
    init(_ grade: String, withStyle style: GradeStyle) {
        switch style {
        case .Letter:
            formatGradeAsLetter(Double(grade)!)
        case .Numerical:
            formatGradeAsNumerical(grade)
        }
    }
    
    mutating private func formatGradeAsNumerical(_ grade: String) {
        internal_formated_grade = String(format: "%.2f", Double(grade)!)
        internal_formated_grade = internal_formated_grade + "%"
    }
    
    mutating private func formatGradeAsLetter(_ grade: Double) {
        if grade >= 97 {
            self.internal_formated_grade = "A+"
        } else if grade >= 93 {
            self.internal_formated_grade = "A"
        } else if grade >= 90 {
            self.internal_formated_grade = "A-"
        } else if grade >= 87 {
            self.internal_formated_grade = "B+"
        } else if grade >= 83 {
            self.internal_formated_grade = "B"
        } else if grade >= 80 {
            self.internal_formated_grade = "B-"
        } else if grade >= 77 {
            self.internal_formated_grade = "C+"
        } else if grade >= 73 {
            self.internal_formated_grade = "C"
        } else if grade >= 70 {
            self.internal_formated_grade = "C-"
        } else if grade >= 67 {
            self.internal_formated_grade = "D+"
        } else if grade >= 63 {
            self.internal_formated_grade = "D"
        } else if grade >= 60 {
            self.internal_formated_grade = "D-"
        } else {
            self.internal_formated_grade = "F"
        }
    }

}
