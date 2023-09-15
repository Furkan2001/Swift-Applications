//
//  DivideViewController.swift
//  FourOperations
//
//  Created by Furkan Ekinci on 14.09.2023.
//

import UIKit

final class DivideViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerText: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var number1:Int?
    private var number2:Int?
    private var timeCounter:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("divide did load")
        self.navigationItem.setHidesBackButton(true, animated: false)
        timeCounter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("divide will appear")
        timeLabel.text = String(time!)
        
        number1 = Int.random(in: 20...200)
        number2 = Int.random(in: 1...20)
        
        while ((number1! % number2!) != 0) { // number1, number2'ye tam bölünebilene kadar
            number1 = Int.random(in: 1...100) // Yeni bir number1 oluştur
            number2 = Int.random(in: 1...100) // Yeni bir number2 oluştur
        }
        
        questionLabel.text = "\(number1!) / \(number2!) = ?"
        scoreLabel.text = "SKORUNUZ: \(score!)"
    }

    @objc func timerFunction(){
        if (time! > 0){
            timeLabel.text = String(time!)
        }
    }
    
    @IBAction func sendAnswer(_ sender: Any) {
        
        if let number = Int(answerText.text ?? ""){
            if ((number1! / number2!) == number){
                score!+=1
                
            }else{
                score!-=1
            }
            number1 = Int.random(in: 20...200)
            number2 = Int.random(in: 1...20)
            
            while ((number1! % number2!) != 0) { // number1, number2'ye tam bölünebilene kadar
                number1 = Int.random(in: 1...100) // Yeni bir number1 oluştur
                number2 = Int.random(in: 1...100) // Yeni bir number2 oluştur
            }
            
            questionLabel.text = "\(number1!) / \(number2!) = ?"
            scoreLabel.text = "SKORUNUZ: \(score!)"
            answerText.text = ""
        }
    }
}
