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
    
    // where save? -> documentDirectory -> Projects.plist
    func dataFileURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Projects.plist")
        
    }
    
    //encode
    func saveProjects() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(projects)
            try data.write(to: dataFileURL(), options: .atomic)
        } catch {
            print("Error encoding projects list array.")
        }
    }
    
    //decoder
    func fetchProjects() {
        let dataFileURL = self.dataFileURL()
        print(dataFileURL)
        if let data = try?  Data(contentsOf: dataFileURL)  {
            let decoder =  PropertyListDecoder()
            do {
                projects = try decoder.decode([Project].self, from: data)
            } catch {
                print("Error decoding projects list array.")
            }
        }
    }
    
    //Adds the contents of the specified dictionary to the registration domain.
    func setupUserDefaults() {
        let dictionary : [String : Any] = ["ProjectIndex": -1, "FirstTimeLaunch": true]
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
    
    //generate an int for each task 
    class func generateNextTaskID()->Int {
        let userDefaults = UserDefaults.standard
        let nextTaskID = userDefaults.integer(forKey: "TaskID") + 1
        
        userDefaults.set(nextTaskID, forKey: "TaskID")
        userDefaults.synchronize()
        
        return nextTaskID
        
    }
}
