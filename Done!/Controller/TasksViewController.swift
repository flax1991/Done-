//
//  TasksViewController.swift
//  Done!
//
//  Created by Flavio Scerra on 23/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController {
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    var project: Project!
    var dataModel = DataModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = addBarButtonItem
        title = project.name
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let taskDetailDC = segue.destination as? TaskDetailViewController
            taskDetailDC?.project = project
            taskDetailDC?.dataModel = dataModel
        }
    }
}

// MARK: - UITableViewDataSource

extension TasksViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return project.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = project.tasks[indexPath.row].text
        
        return cell
    }

}
