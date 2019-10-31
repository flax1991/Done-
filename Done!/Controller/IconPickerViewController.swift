//
//  IconPickerViewController.swift
//  Done!
//
//  Created by Flavio Scerra on 22/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit

// create a protocol to change the icon 
protocol IconPickerViewControllerDelegate: class {
    func iconPickerDidFinishPick(_ icon: String)
}

class IconPickerViewController: UITableViewController {
    
    let icons = ["Baby", "Birthday-cake", "Cheers", "Party", "Email", "Family", "Groceries", "Play", "Shopping-basket", "Sports", "Trip", "Work", "Wedding"]
    
    // create an instance 
    weak var delegate : IconPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        title = "Pick Icon"
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let icon = icons[indexPath.row]
        
        cell.textLabel?.text = icon
        cell.imageView?.image = UIImage(named: icon)
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.iconPickerDidFinishPick(icons[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
    
    // animation cell
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 0.55) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
        
    }
}
