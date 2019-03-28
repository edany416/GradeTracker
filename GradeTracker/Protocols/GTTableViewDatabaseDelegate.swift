//
//  GTTableViewDatabaseDelegate.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/24/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

protocol GTTableViewDataBaseDelegate {
    func updateElement(at index: Int, withUpdatedInfoFrom newElement: Displayable)
    func add(PresentableElement newElement: Displayable) -> Bool
    func element(at index: Int) -> Displayable
    func remove(at index: Int)
    func count() -> Int
}
