//
//  BudgetStatusForGuestViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 29.08.2023.
//

import UIKit

final class BudgetStatusForGuestViewController: UIViewController {

    @IBOutlet weak var income: UITextField!
    @IBOutlet weak var kitchen: UITextField!
    @IBOutlet weak var transport: UITextField!
    @IBOutlet weak var water: UITextField!
    @IBOutlet weak var naturalGas: UITextField!
    @IBOutlet weak var electric: UITextField!
    @IBOutlet weak var clothes: UITextField!
    @IBOutlet weak var entertainment: UITextField!
    @IBOutlet weak var others: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func calculate(_ sender: Any) {
        var sumIncome : Float = 0.0
        var sumExpense : Float = 0.0
        
        if let temp = income.text{
            if let dummyIncome = Float(temp){
                sumIncome += dummyIncome
            }
        }
        
        if let temp = kitchen.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = transport.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = water.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = naturalGas.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = electric.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = clothes.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = entertainment.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        if let temp = others.text{
            if let dummyIncome = Float(temp){
                sumExpense += dummyIncome
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let answerView = storyboard.instantiateViewController(withIdentifier: "answerForGuest") as? AnswerForGuestViewController{
            
            if sumIncome > sumExpense{
                
                answerView.text1 = "TEBRİKLER"
                answerView.text2 = "Bu ayki geliriniz giderlerinizden \(sumIncome - sumExpense) TL daha fazla. Eğer birikimlerinize devam ederseniz refah düzeyiniz giderek artacaktır. Sağlıklı ve huzurlu günler dilerim..."
                navigationController?.pushViewController(answerView, animated: true)
            }
            else if sumIncome == sumExpense{
                
                answerView.text1 = "BAŞARILI"
                answerView.text2 = "Bu ayki geliriniz giderlerinize eşit. Eğer birikim yapmak isterseniz daha fazla kazanmalı ya da biraz daha harcamalardan kısmalısınız. Unutmayın güzel bir geleceğin yolu birikimden geçer. Sağlıklı ve huzurlu günler dilerim..."
                navigationController?.pushViewController(answerView, animated: true)
            }
            else{
                
                answerView.text1 = "ÇABALAMALISIN"
                answerView.text2 = "Bu ayki geliriniz giderlerinizden daha az. Daha güzel bir yaşam için daha çok çalışmalısınız. Eğer birikim yapmak isterseniz daha fazla kazanmalı ya da biraz daha harcamalardan kısmalısınız. Unutmayın güzel bir geleceğin yolu birikimden geçer. Sağlıklı ve huzurlu günler dilerim..."
                navigationController?.pushViewController(answerView, animated: true)
            }
        }
    }
    

}
