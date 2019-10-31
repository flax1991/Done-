//
//  ProjectDetailViewController.swift
//  Done!
//
//  Created by Flavio Scerra on 20/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var iconImageView:UIImageView!
    @IBOutlet weak var cancelBarButtonItem:UIBarButtonItem!
    @IBOutlet weak var savebarButtonItem:UIBarButtonItem!
    
    var iconName = "questions" {
        didSet {
            iconImageView.image = UIImage(named: iconName)
        }
    }
    var dataModel : DataModel!
    var projectToEdit: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = savebarButtonItem
        iconImageView.image = UIImage(named: iconName)
        nameTextField.becomeFirstResponder()
        
        if let projectToEdit = projectToEdit {
            iconName = projectToEdit.iconName
            nameTextField.text = projectToEdit.name
            title = "Edit Project"
        }
        
    }
    
    // MARK: - target / Action
    @IBAction func save(){
        guard let text = nameTextField.text, !text.isEmpty else {return}
        
        if let projectToEdit = projectToEdit {
            projectToEdit.name = nameTextField.text!
            projectToEdit.iconName = iconName
        } else {
            let newProject = Project(name: text, iconName: iconName )
            dataModel.projects.append(newProject)
            
        }
        //save in...
        dataModel.saveProjects()
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func delete() {
        // create alert for deleteting
        if let projectToEdit = projectToEdit {
            let alert = UIAlertController(title: "Are you Sure?", message: "If Deleteting the project you will not be able to recover it.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                
                if let projectIndex = self.dataModel.projects.firstIndex(of: projectToEdit) {
                    self.dataModel.projects.remove(at: projectIndex)
                    self.dataModel.saveProjects()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            alert.addAction(cancel)
            alert.addAction(delete)
            
            present(alert, animated: true, completion: nil)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowIconList" {
            let iconPickerVC = segue.destination as? IconPickerViewController
            iconPickerVC?.delegate = self
            
        }
    }
}
extension ProjectDetailViewController: IconPickerViewControllerDelegate {
    
    func iconPickerDidFinishPick(_ icon: String) {
        iconName = icon
    }
}
