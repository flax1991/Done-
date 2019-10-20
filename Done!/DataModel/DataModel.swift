//
//  DataModel.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import Foundation

class DataModel {
    
    var projects = [Project]()
    var selectedProjectIndex:Int {
        get  {
            return  UserDefaults.standard.integer(forKey: "ProjectIndex")
        }
        set  {
            UserDefaults.standard.set(newValue, forKey: "ProjectIndex")
        }
    }
    
    init() {
        fetchProjects()
        setupUserDefaults()
        handleFirstTimeLaunch()
    }
    
    func dataFileURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Projects.plist")
        
    }
    
    func fetchProjects() {
        let dataFileURL = self.dataFileURL()
        if let data = try?  Data(contentsOf: dataFileURL)  {
            let decoder =  PropertyListDecoder()
            do {
                projects = try decoder.decode([Project].self, from: data)
            } catch {
                print("Error decoding projects list array!")
            }
        }
    }
    
    func setupUserDefaults() {
        let dictionary : [String:Any] = ["ProjectIndex":-1, "FirstTimeLaunch":true]
        UserDefaults.standard.register(defaults: dictionary)
        
    }
    
    func handleFirstTimeLaunch() {
        let userDefaults =  UserDefaults.standard
        let isFirstTimeLaunch = userDefaults.bool(forKey: "FirstTimeLaunch")
        
        
        if isFirstTimeLaunch {
            let  project  =  Project(name: "New Project")
            projects.append(project)
            selectedProjectIndex  = 0
            
            userDefaults.set(false, forKey: "FirstTimeLaunch")
            userDefaults.synchronize()
        }
      }
    
    class func generateNextTaskID()->Int {
        let userDefaults = UserDefaults.standard
        let nextTaskID = userDefaults.integer(forKey: "TaskID")
        
        userDefaults.set(nextTaskID, forKey: "TaskID")
        userDefaults.synchronize()
        
        return nextTaskID
        
    }
}
