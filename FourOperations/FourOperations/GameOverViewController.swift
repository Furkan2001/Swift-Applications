//
//  GameOverViewController.swift
//  FourOperations
//
//  Created by Furkan Ekinci on 14.09.2023.
//

import UIKit

final class GameOverViewController: UIViewController {

    @IBOutlet weak var maxScore: UILabel!
    @IBOutlet weak var yourScoreForLastGame: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        maxScore.text = "En Yüksek Skorunuz: \(UserDefaults.standard.integer(forKey: "score"))"
        yourScoreForLastGame.text = "SKORUNUZ: \(score!)"
    }

    @IBAction func playAgain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
