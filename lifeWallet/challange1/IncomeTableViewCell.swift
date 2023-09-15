//
//  IncomeTableViewCell.swift
//  challange1
//
//  Created by Furkan Ekinci on 9.09.2023.
//

import UIKit

final class IncomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfIncome: UILabel!
    @IBOutlet weak var priceOfIncome: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
