//
//  CreateIndividualTeamViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 7.09.2023.
//

import UIKit

//Team bireysel olduğu için team_type_id si 1 olacak... 

final class CreateIndividualTeamViewController: UIViewController {

    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var username:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultLabel.isHidden = true
        if let name = UserDefaults.standard.string(forKey: "username") {
            self.username = name
        }
    }
    
    @IBAction func createTeam(_ sender: Any) {
        
        if let teamName = teamNameTextField.text, teamName != ""{
            let idForUser = Usersdao().enterUsernameFindUserId(username: self.username!)
            Teamsdao().addNewUser(user_id: idForUser, team_name: teamName, team_type_id: 1)//Team bireysel olduğu için team_type_id si 1 olacak...
            self.resultLabel.isHidden = false
            resultLabel.text = "Tebrikler, ekibiniz başarıyla oluşturuldu"
        }else{
            self.resultLabel.isHidden = false
            resultLabel.text = "Lütfen bir ekip ismi giriniz"
        }
    }
    
    

}
