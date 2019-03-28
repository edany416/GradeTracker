//
//  CriteriaViewController.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import UIKit

class CriteriaViewController: GTBaseViewController {
    
    private var activityRecorder: UserActivityRecorder!
    
    deinit {
        activityRecorder.endRecording()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityRecorder = UserActivityRecorder(listeningForNotificationNamed: NotificationNames.dataModified)
        self.title = (databaseDelegate as? Displayable)?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if activityRecorder.userModifiedData() {
            (databaseDelegate as! Course).updateGrade()
            DataPersistenceService.saveData()
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexOfSwipedCell != nil {
            let name = Notification.Name(NotificationNames.dataModified)
            NotificationCenter.default.post(name: name, object: nil)
            (databaseDelegate as! Course).updateGrade()
            indexOfSwipedCell = nil
        }
    }
    
    
}
