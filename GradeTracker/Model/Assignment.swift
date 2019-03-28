//
//  Assignment.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation


class Assignment: NSObject, Displayable, NSCoding {
    var grade: String?
    var name: String
    var weight: Double
    
    // Grade double garentees we can convert string grade to
    // Double risk free in order to do grade calculations
    init(_ name: String, grade: Double, weight: Double) {
        self.name = name
        self.grade = String(grade)
        self.weight = weight
    }
    
    func update(FromUpdatedItem item: Displayable) {
        if let assignment = item as? Assignment {
            self.name = assignment.name
            self.grade = assignment.grade
            self.weight = assignment.weight
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(grade, forKey: PropertyKeys.grade)
        aCoder.encode(weight, forKey: PropertyKeys.weight)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: PropertyKeys.name) as! String
        self.grade = aDecoder.decodeObject(forKey: PropertyKeys.grade) as? String
        self.weight = aDecoder.decodeDouble(forKey: PropertyKeys.weight)
    }
    
    
}
