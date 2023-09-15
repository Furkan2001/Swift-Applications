//
//  MyTeamsViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 7.09.2023.
//

import UIKit

final class MyTeamsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var myTeamsArray = [Teams]()
    private var username:String?
    private var idForUser:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        if let name = UserDefaults.standard.string(forKey: "username") {
            self.username = name
        }
        idForUser = Usersdao().enterUsernameFindUserId(username: self.username!)
        
        myTeamsArray = Teamsdao().returnTeamsInId(id: idForUser!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTeamsArray = Teamsdao().returnTeamsInId(id: idForUser!)
        tableView.reloadData()
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: "team_id")
        userDefaults.removeObject(forKey: "user_id")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myTeamsToIndividualTeam"{
            if let individualTeamPage = segue.destination as? IndividualTeamViewController {
                individualTeamPage.memberOfTeam = sender as! Teams
            }
        }else if segue.identifier == "myTeamsToGroupTeam"{
            if let groupTeamPage = segue.destination as? GroupTeamViewController {
                groupTeamPage.memberOfTeam = sender as! Teams
            }
        }
    }
}

extension MyTeamsViewController:UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTeamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTeamsCell", for: indexPath) as! MyTeamsTableViewCell
        
        cell.teamNameButton.setTitle("\(myTeamsArray[indexPath.row].team_name ?? "")", for: .normal)
        //var content = cell.defaultContentConfiguration()
        //content.text = "\(myTeamsArray[indexPath.row].team_name ?? "")"
        //cell.contentConfiguration = content
        cell.indexPathReal = indexPath
        cell.myTeamsTableViewCellProtocol = self

        return cell
    }
}

extension MyTeamsViewController:MyTeamsTableViewCellProtocol{
    func touchedToTeamButtonProtocol(indexPath: IndexPath) {
        if myTeamsArray[indexPath.row].team_type_id == 1{
            performSegue(withIdentifier: "myTeamsToIndividualTeam", sender: myTeamsArray[indexPath.row])
        }else{
            performSegue(withIdentifier: "myTeamsToGroupTeam", sender: myTeamsArray[indexPath.row])
        }
    }
}
