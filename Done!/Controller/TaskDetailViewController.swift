//
//  TaskDetailViewController.swift
//  Done!
//
//  Created by Flavio Scerra on 23/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit

class TaskDetailViewController: UITableViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var shouldRemindMeSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dueDate = Date()
    var project : Project!
    var dataModel : DataModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
        title = "New Task"
        dateLabel.textColor = UIColor.lightGray
        taskTextField.becomeFirstResponder()
    }
    
    
    
    // MARK: Target / Action
    
    @IBAction func save() {
        guard let text = taskTextField.text, !text.isEmpty else {return}
        let newtask = Task(text: text, isChecked: false, shouldRemind: shouldRemindMeSwitch.isOn, dueDate: dueDate)
        project.tasks.append(newtask)
        dataModel.saveProjects()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchPress(_ sender: UISwitch) {
        if sender.isOn {
            dateLabel.textColor = UIColor.black
        } else {
            dateLabel.textColor = UIColor.lightGray
        }
    }
}
