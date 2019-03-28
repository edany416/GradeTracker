//
//  GradeCalculator.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

struct GradeCalculator {
    
    static func computedGradeFor(Assignments assignments: [Assignment]) -> String? {
        
        var totalPointsEarned: Double?
        var totalPointsAvailable: Double?
        var grade: String?
        
        for assignment in assignments {
            let convertedProportion = assignment.weight/100.0
            if totalPointsEarned == nil {
                totalPointsEarned = Double()
            }
            if totalPointsAvailable == nil {
                totalPointsAvailable = Double()
            }
            
            totalPointsEarned! += Double((assignment.grade!))!*convertedProportion
            totalPointsAvailable! += assignment.weight
        }
        
        if let earned = totalPointsEarned, let available = totalPointsAvailable {
            grade = String(earned/available * 100.0)
            
        }
        
        return grade
    }
    
}
