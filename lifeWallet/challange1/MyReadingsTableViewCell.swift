//
//  MyReadingsTableViewCell.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class MyReadingsTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameOfBookTextVİew: UITextView!
    @IBOutlet weak var numberOfBookPageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
