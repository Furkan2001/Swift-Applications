//
//  MondayTableViewCell.swift
//  LessonProgram
//
//  Created by Furkan Ekinci on 13.09.2023.
//

import UIKit

class MondayTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mondayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
