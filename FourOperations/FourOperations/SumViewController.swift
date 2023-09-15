//
//  SumViewController.swift
//  FourOperations
//
//  Created by Furkan Ekinci on 14.09.2023.
//

import UIKit

class SumViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerText: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var number1:Int!
    private var number2:Int!
    private var timeCounter:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sum did load")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        timeCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("sum will appear")
        number1 = Int.random(in: 1...100)
        number2 = Int.random(in: 1...100)
        
        questionLabel.text = "\(number1!) + \(number2!) = ?"
        scoreLabel.text = "SKORUNUZ: \(score!)"
    }
    
    @objc func timerFunction(){

        time!-=1
        timeLabel.text = String(time!)
        
        if (time! == 0){
            let maxScore = UserDefaults.standard.integer(forKey: "score")
            if (maxScore < score!){
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: "score")
                userDefaults.setValue(score!, forKey: "score")
            }
            timeCounter?.invalidate()
            performSegue(withIdentifier: "sumToGameOver", sender: nil)
        }
    }

    @IBAction func sendAnswer(_ sender: Any) {
        
        if let number = Int(answerText.text ?? ""){
            if ((number1 + number2) == number){
                score!+=1
            }else{
                score!-=1
            }
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...100)
            questionLabel.text = "\(number1!) + \(number2!) = ?"
            scoreLabel.text = "SKORUNUZ: \(score!)"
            answerText.text = ""
        }
    }
}
