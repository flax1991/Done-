//
//  Project.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import Foundation

class Project: NSObject, Codable {
     
    var name = ""
    var tasks = [Task]()
    var iconName = "checklist"
    
    init(name:String, iconName:String = "checklist") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    // how many task remaning
    func countUncheckedTask() -> Int {
       var count = 0
        
        for task in tasks where !task.isChecked {
            count += 1
        }
        return count
    }
    
}
