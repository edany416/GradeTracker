//
//  Course.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

class Course: NSObject, NSCoding, Displayable, GTTableViewDataBaseDelegate, Gradeable {
    private var criterias = [GradingCriteria]()
    
    var grade: String?
    var name: String
    
    
    init(withName name: String) {
        self.name = name
    }
    
    func update(FromUpdatedItem item: Displayable) {
        if let course = item as? Course {
            self.name = course.name
        }
    }
    
    func updateElement(at index: Int, withUpdatedInfoFrom newElement: Displayable) {
        criterias[index].update(FromUpdatedItem: newElement)
    }
    
    func add(PresentableElement newElement: Displayable) -> Bool {
        let duplicateFound = criterias.contains { (newElement.name == $0.name)}
        if !duplicateFound, let criteria = newElement as? GradingCriteria {
            criterias.append(criteria)
        }
        return !duplicateFound
    }
    
    func element(at index: Int) -> Displayable {
        return criterias[index]
    }
    
    func remove(at index: Int) {
        criterias.remove(at: index)
    }
    
    func count() -> Int {
        return criterias.count
    }
    
    func associatedAssignments() -> [Assignment] {
        var allAssignments = [Assignment]()
        for criteria in criterias {
            for index in 0..<criteria.count() {
                allAssignments.append(criteria.element(at: index) as! Assignment)
            }
        }
        return allAssignments
    }
    
    func updateGrade() {
        self.grade = GradeCalculator.computedGradeFor(Assignments: associatedAssignments())
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(criterias, forKey: PropertyKeys.criterias)
        aCoder.encode(grade, forKey: PropertyKeys.grade)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: PropertyKeys.name) as! String
        self.criterias = aDecoder.decodeObject(forKey: PropertyKeys.criterias) as! [GradingCriteria]
        if let grade = aDecoder.decodeObject(forKey: PropertyKeys.grade) as? String {
            self.grade = grade
        }
    }
    

    
}
