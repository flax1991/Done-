//
//  TaskCell.swift
//  Done!
//
//  Created by Flavio Scerra on 24/10/2019.
//  Copyright © 2019 flavio scerra. All rights reserved.
//

import UIKit


protocol TaskCellDelegate: class {
    func taskCell(_ cell: TaskCell, didToggleCheckedTask: Task )
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    weak var delegate: TaskCellDelegate?
    var task: Task! {
        didSet {
            setupUI()
        }
    }
    
    @IBAction func checkDidTap() {
        task.toggleChecked()
        setupUI()
        delegate?.taskCell(self, didToggleCheckedTask: task)
    }
    
    func setupUI() {
        checkmarkButton.setTitle(task.isChecked ? "☑︎" : "□", for: .normal)
        label.attributedText = NSAttributedString(string: task.text, attributes: task.isChecked ? [.strikethroughStyle : true] : [:])
    }
 
}
