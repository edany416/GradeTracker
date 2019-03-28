//
//  DataManager.swift
//  GradeTracker
//
//  Created by edan yachdav on 6/26/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation
import os.log

class DataPersistenceService {
    private static var dataList: CourseArray?
    
    init(dataList: CourseArray) {
        DataPersistenceService.dataList = dataList
    }
    
    static func saveData() {
        
        if let list = dataList {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(list.coursesArray(), toFile: DataPersistenceService.ArchiveURL.path)
            
            if isSuccessfulSave {
                os_log("Courses successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save course...", log: OSLog.default, type: .error)
            }
        }
    }
    
    static func loadData() -> [Course]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: DataPersistenceService.ArchiveURL.path) as? [Course]
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("courses")
}
