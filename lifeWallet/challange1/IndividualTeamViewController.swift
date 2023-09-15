//
//  IndividualTeamViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 7.09.2023.
//

import UIKit

final class IndividualTeamViewController: UIViewController {

    var memberOfTeam = Teams()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewController = self.navigationController?.topViewController {
            viewController.navigationItem.title = memberOfTeam.team_name
        }

        //dump(memberOfTeam)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(memberOfTeam.team_id, forKey: "team_id")
        userDefaults.set(memberOfTeam.user_id, forKey: "user_id")
    }
    
    
    @IBAction func deleteThisTeam(_ sender: Any) {
        
        Teamsdao().removeElement(whereId: UserDefaults.standard.integer(forKey: "team_id"))
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: "team_id")
        userDefaults.removeObject(forKey: "user_id")
        
        navigationController?.popViewController(animated: true)
    }
    
}
