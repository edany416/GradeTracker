//
//  AssignmentsViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class AssignmentsViewController: GTBaseViewController {
    
    private var userActivityRecorder: UserActivityRecorder!
    
    deinit {
        userActivityRecorder.endRecording()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userActivityRecorder = UserActivityRecorder(listeningForNotificationNamed: NotificationNames.dataModified)
        self.title = (databaseDelegate as? Displayable)?.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if userActivityRecorder.userModifiedData() {
            (databaseDelegate as! GradingCriteria).updateGrade()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexOfSwipedCell != nil {
            let name = Notification.Name(NotificationNames.dataModified)
            NotificationCenter.default.post(name: name, object: nil)
            (databaseDelegate as! GradingCriteria).updateGrade()
            indexOfSwipedCell = nil
        }
    }
}
