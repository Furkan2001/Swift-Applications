//
//  ExpenseTableViewCell.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfExpense: UILabel!
    @IBOutlet weak var priceOfExpense: UILabel!
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
