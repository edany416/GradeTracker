//
//  GradingCriteria.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

class GradingCriteria:NSObject, NSCoding, GTTableViewDataBaseDelegate, Gradeable, Displayable {
    private var assignments = [Assignment]()
    var grade: String? {
        didSet {
            DataPersistenceService.saveData()
        }
    }
    var name: String

    init(_ name: String) {
        self.name = name
    }
    
    func update(FromUpdatedItem item: Displayable) {
        if let criteria =  item as? GradingCriteria {
            self.name = criteria.name
        }
    }
    
    func updateElement(at index: Int, withUpdatedInfoFrom newElement: Displayable) {
        assignments[index].update(FromUpdatedItem: newElement)
    }
    
    func add(PresentableElement newElement: Displayable) -> Bool {
        let duplicateFound = assignments.contains { (newElement.name == $0.name)}
        if !duplicateFound, let assignment = newElement as? Assignment {
            assignments.append(assignment)
        }
        return !duplicateFound
    }
    
    func element(at index: Int) -> Displayable {
        return assignments[index]
    }
    
    func remove(at index: Int) {
        assignments.remove(at: index)
    }
    
    func count() -> Int {
        return assignments.count
    }
    
    func associatedAssignments() -> [Assignment] {
        return assignments
    }
    
    func updateGrade() {
        self.grade = GradeCalculator.computedGradeFor(Assignments: assignments)
    }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(assignments, forKey: PropertyKeys.assignments)
        aCoder.encode(grade, forKey: PropertyKeys.grade)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: PropertyKeys.name) as! String
        self.assignments = aDecoder.decodeObject(forKey: PropertyKeys.assignments) as! [Assignment]
        if let grade = aDecoder.decodeObject(forKey: PropertyKeys.grade) as? String {
            self.grade = grade
        }
    }
}
