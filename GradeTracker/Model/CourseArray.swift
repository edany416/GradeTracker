//
//  CourseArray.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

class CourseArray:NSObject, GTTableViewDataBaseDelegate, NSCoding {
    private var courses = [Course]()
    
    override init() {}
    
    init(_ courses: [Course]) {
        self.courses += courses
    }
    
    func coursesArray() -> [Course] {
        return courses
    }
    
    func updateElement(at index: Int, withUpdatedInfoFrom newElement: Displayable) {
        if let course = newElement as? Course {
            courses[index].update(FromUpdatedItem: course)
        }
    }
    
    func add(PresentableElement newElement: Displayable) -> Bool {
        let duplicateFound = courses.contains{(newElement.name == $0.name)}
        if !duplicateFound, let course = newElement as? Course {
            courses.append(course)
        }
        return !duplicateFound
    }
    
    func element(at index: Int) -> Displayable {
        return courses[index]
    }
    
    func remove(at index: Int) {
        courses.remove(at: index)
    }
    
    func count() -> Int {
        return courses.count
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courses, forKey: PropertyKeys.courses)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.courses = aDecoder.decodeObject(forKey: PropertyKeys.courses) as! [Course]
    }
}
