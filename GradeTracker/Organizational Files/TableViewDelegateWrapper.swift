//
//  TableViewDataSourceWrapper.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/25/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation
import UIKit

enum GTCellSwipeAction {
    case Delete
    case Edit
}

class TableViewDelegateWrapper: NSObject, UITableViewDelegate {
    
    var swipeActionDelegate: GTTableViewSwipeActionDelegate?
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.swipeActionDelegate?.cellSwiped(at: indexPath, withAction: GTCellSwipeAction.Delete)
            completionHandler(true)
        }
        
        let edit = UIContextualAction(style: .destructive, title: "Edit") { (action, sourceView, completionHandler) in
            self.swipeActionDelegate?.cellSwiped(at: indexPath, withAction: GTCellSwipeAction.Edit)
            completionHandler(true)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        let swipeAction = UISwipeActionsConfiguration(actions: [delete,edit])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
}

