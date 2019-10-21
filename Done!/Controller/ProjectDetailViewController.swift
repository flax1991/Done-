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
    
    var iconName = "checklist"
    var dataModel : DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = savebarButtonItem
        iconImageView.image = UIImage(named: iconName)
        nameTextField.becomeFirstResponder()
        
    }
    
    
    @IBAction func save(){
        guard let text = nameTextField.text, !text.isEmpty else {return}
        let newProject = Project(name: text, iconName: iconName )
        dataModel.projects.append(newProject)
        dataModel.saveProjects()
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func delete() {
        
    }
    
}
