//
//  GTTableViewActionDelegate.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/25/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

protocol GTTableViewSwipeActionDelegate {
    func cellSwiped(at indexPath: IndexPath, withAction action: GTCellSwipeAction)
}
