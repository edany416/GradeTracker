//
//  CoursesViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class HomeScreenViewController: GTBaseViewController {
    
    private var courses = CourseArray()

    override func viewDidLoad() {
        super.viewDidLoad()
            
        if let savedCourses = DataPersistenceService.loadData() {
            courses = CourseArray(savedCourses)
        }
        
        databaseDelegate = courses
        tableView.reloadData()
        
        _ = DataPersistenceService(dataList: courses)
    }
}
