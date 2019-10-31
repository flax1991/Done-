//
//  Task.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import Foundation
import UserNotifications

class Task : NSObject, Codable {
    
    var text = ""
    var isChecked = false
    var dueDate = Date()
    var shouldRemind = false
    var taskID: Int
    
        init(text: String, isChecked:Bool, shouldRemind: Bool, dueDate: Date) {
        self.text = text
        self.isChecked = isChecked
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        taskID = DataModel.generateNextTaskID()
    }
    
    override init() {
        taskID = DataModel.generateNextTaskID()
    }
    
    deinit {
        removeNotification()
    }
    
    func toggleChecked() {
        isChecked = !isChecked
        
  }
    
    // Reminder
     func scheduleReminderNotification() {
         removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(taskID)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
     }
     
     func removeNotification() {
         UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(taskID)"])
     }
    
}
