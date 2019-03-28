//
//  UserActivityRecorder.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

class UserActivityRecorder {
    
    private var changesMade = false
    
    init(listeningForNotificationNamed notificationName: String) {
        let name = Notification.Name(rawValue: notificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(UserActivityRecorder.setChangesMade), name: name, object: nil)
    }
    
    func userModifiedData() -> Bool {
        return changesMade
    }
    
    func endRecording() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func setChangesMade() {
        changesMade = true
    }
}
