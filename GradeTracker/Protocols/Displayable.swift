//
//  Presentable.swift
//  GradeTracker
//
//  Created by edan yachdav on 7/21/18.
//  Copyright © 2018 edan yachdav. All rights reserved.
//

import Foundation

protocol Displayable {
    var name: String {get set}
    var grade: String? {get}
    func update(FromUpdatedItem item: Displayable)
}
