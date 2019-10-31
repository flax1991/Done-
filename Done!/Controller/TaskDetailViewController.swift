//
//  TaskDetailViewController.swift
//  Done!
//
//  Created by Flavio Scerra on 23/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit
import UserNotifications

class TaskDetailViewController: UITableViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var shouldRemindMeSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    
    var dueDate = Date()
    var isDatePickerIsVisible = false // if date Picker is visible or not
    var project : Project!
    var dataModel : DataModel!
    var taskToEdit: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
        title = "New Task"
        dateLabel.textColor = .lightGray
        
        taskTextField.becomeFirstResponder()
        clockImage.transform = CGAffineTransform(rotationAngle: -50)
        
        if let taskToEdit = taskToEdit {
            title = "Edit Task"
            taskTextField.text = taskToEdit.text
            shouldRemindMeSwitch.isOn = taskToEdit.shouldRemind
            dueDate = taskToEdit.dueDate
            
            
        }
        
        updateDueDateLabel()
    }
    
    
     // MARK: Target / Action
    
    @IBAction func save() {
        guard let text = taskTextField.text, !text.isEmpty else {return}
        
        if let taskToEdit = taskToEdit{
            taskToEdit.text = taskTextField.text!
            taskToEdit.shouldRemind = shouldRemindMeSwitch.isOn
            taskToEdit.dueDate = dueDate
            
            if shouldRemindMeSwitch.isOn {
                
                taskToEdit.scheduleReminderNotification()
            }
            
        } else {
            let newtask = Task(text: text, isChecked: false, shouldRemind: shouldRemindMeSwitch.isOn, dueDate: dueDate)
            project.tasks.append(newtask)
            
            if shouldRemindMeSwitch.isOn {
                newtask.scheduleReminderNotification()
            }
            
        }
        
        dataModel.saveProjects()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shouldRemindMeToggled(_ switchControl: UISwitch) {
        taskTextField.resignFirstResponder()
        if switchControl.isOn {
            // request requestAuthorization
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                //...
            }
            
        }
    }
    
  // MARK: - DueDate
    func updateDueDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: dueDate)
    }
    
    @IBAction func dueDateChange(_ datePicker: UIDatePicker) {
        dueDate = datePicker.date
        updateDueDateLabel()
    }
    
    // need two methods
    
    func showDatePicker() {
        isDatePickerIsVisible = true
        let indexPatForDueDateRow = IndexPath(row: 1, section: 1)
        let indexPathForDatePicker = IndexPath(row: 2, section: 1)
        
        // check
        
        if let dueDateCell = tableView.cellForRow(at: indexPatForDueDateRow) {
            dueDateCell.detailTextLabel?.textColor = dueDateCell.detailTextLabel?.tintColor
        }
        
        tableView.beginUpdates()
        
        // in the middle
        tableView.insertRows(at: [indexPathForDatePicker], with: .fade)
        tableView.reloadRows(at: [indexPatForDueDateRow], with: .none)
        
        
        //After updates..
        tableView.endUpdates()
    }
    
    func hideDatePicker() {
        isDatePickerIsVisible = false
        let indexPatForDueDateRow = IndexPath(row: 1, section: 1)
        let indexPathForDatePicker = IndexPath(row: 2, section: 1)
        
        // check
        if let dueDateCell = tableView.cellForRow(at: indexPatForDueDateRow) {
            dueDateCell.detailTextLabel?.textColor = .lightGray
        }
        
        tableView.beginUpdates()
        
        // in the middle
        tableView.deleteRows(at: [indexPathForDatePicker], with: .fade)
        tableView.reloadRows(at: [indexPatForDueDateRow], with: .none)
        
        
        //After updates..
        tableView.endUpdates()
    }
}

 // MARK: UITableViewDataSource

extension TaskDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && isDatePickerIsVisible {
            return 3
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    // next...
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 2 {
            return datePickerCell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    //next..
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            return 217
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // Then..
    // click the cell only when show dataPicker
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    // then..
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        taskTextField.resignFirstResponder()
        
        //check
        if indexPath.section == 1 && indexPath.row == 1 {
            if !isDatePickerIsVisible {
                showDatePicker()
            } else {
                hideDatePicker()
            }
        }
    }
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var newIndexPath = indexPath
        if indexPath.section == 1 && indexPath.row == 2 {
            newIndexPath = IndexPath(row: 0, section: indexPath.section)
            
        }
        
        return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
    }
}
