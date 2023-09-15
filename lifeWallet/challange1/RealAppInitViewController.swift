//
//  RealAppInitViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 1.09.2023.
//

import UIKit

final class RealAppInitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    
    @IBAction func createTeam(_ sender: Any) {
        
    }
    
    @IBAction func createIndividualTeam(_ sender: Any) {
        
    }
    
    @IBAction func myTeams(_ sender: Any) {
        
    }
    
    @IBAction func toDoList(_ sender: Any) {
        
    }
}
