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
        } else if segue.identifier == "ShowProjectTask" {
            let  taskVC = segue.destination as! TasksViewController
            taskVC.dataModel = dataModel
            if let indexPath = tableView.indexPathForSelectedRow {
                taskVC.project  = dataModel.projects[indexPath.row]
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
       
        
        // count how many task 
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
    
    // Delete swipe cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataModel.projects.remove(at: indexPath.row)
            dataModel.saveProjects()
            // UpdateUI
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
