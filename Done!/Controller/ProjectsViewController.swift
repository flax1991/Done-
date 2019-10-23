//
//  ProjectsViewController.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController  {
    
    var dataModel = DataModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
             let projectDetailVC = segue.destination as! ProjectDetailViewController
                projectDetailVC.dataModel = dataModel
        } else if segue.identifier == "ShowProjectDetail" {
            let projectDetailVC = segue.destination as! ProjectDetailViewController
            projectDetailVC.dataModel = dataModel
            if let indexPath = sender as? IndexPath {
                let selectedProject = dataModel.projects[indexPath.row]
                projectDetailVC.projectToEdit = selectedProject
            }
        }
    }
}

extension ProjectsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let project = dataModel.projects[indexPath.row]
        cell.textLabel?.text = project.name
        cell.accessoryType = .detailDisclosureButton
        cell.imageView?.image = UIImage(named: project.iconName)
        cell.imageView?.contentMode = .scaleAspectFit
       
        
        let uncheckedTaskCount = project.countUncheckedTask()
        if project.tasks.count == 0 {
            cell.detailTextLabel?.text = "No task."
        } else if uncheckedTaskCount == 0 {
            cell.detailTextLabel?.text = "All Done."
        } else {
            cell.detailTextLabel?.text = "\(uncheckedTaskCount) Task Remaning"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowProjectDetail", sender: indexPath)
    }
}
