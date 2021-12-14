//
//  ToDoItemTableViewCell.swift
//  ToDoList
//
//  Created by administrator on 13/12/2021.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var toDoDate: UILabel!
    @IBOutlet weak var toDoNote: UILabel!
    @IBOutlet weak var editButton: UIButton!
    var checkMark: Bool = false
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
