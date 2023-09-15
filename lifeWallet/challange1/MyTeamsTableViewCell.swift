//
//  MyTeamsTableViewCell.swift
//  challange1
//
//  Created by Furkan Ekinci on 7.09.2023.
//

import UIKit

protocol MyTeamsTableViewCellProtocol{
    func touchedToTeamButtonProtocol(indexPath: IndexPath)
}

final class MyTeamsTableViewCell: UITableViewCell {


    @IBOutlet weak var teamNameButton: UIButton!
    
    var indexPathReal: IndexPath?
    var myTeamsTableViewCellProtocol: MyTeamsTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func touchedToTeamButton(_ sender: Any) {
        myTeamsTableViewCellProtocol?.touchedToTeamButtonProtocol(indexPath: indexPathReal!)
    }
}
