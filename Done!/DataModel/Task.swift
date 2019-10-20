//
//  Task.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import Foundation

class Task : NSObject, Codable {
    
    var text = ""
    var isChecked = false
    var dueDate = Date()
    var shouldRemind = false
    var taskID: Int
    
    override init() {
        taskID = DataModel.generateNextTaskID()
    }
    
    func toggleChecked() {
        isChecked = !isChecked
        
  }
    
}
