//
//  FridayTableViewCell.swift
//  LessonProgram
//
//  Created by Furkan Ekinci on 13.09.2023.
//

import UIKit

class FridayTableViewCell: UITableViewCell {

    @IBOutlet weak var fridayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
