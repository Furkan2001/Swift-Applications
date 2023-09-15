//
//  AddNewIncomeViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 9.09.2023.
//

import UIKit

final class AddNewIncomeViewController: UIViewController {

    @IBOutlet weak var descriptionOfIncomeTextField: UITextField!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var dateOfIncomeTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateOfIncomeTextField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(chooseDate(datePicker:)), for: .valueChanged)
        
        let touchToSpace = UITapGestureRecognizer(target: self, action: #selector(touchSpace))
        
        self.view.addGestureRecognizer(touchToSpace)
        self.resultLabel.isHidden = true
    }
    
    
    @IBAction func addNewIncomeToDatabase(_ sender: Any) {
        
        if let description = descriptionOfIncomeTextField.text, description.count > 0{
            if let text = incomeTextField.text, let floatValue = Float(text) {
                if let dateText = dateOfIncomeTextField.text, !dateText.isEmpty {
                    Incomedao().addNewIncome(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"), income_description: description, income: floatValue, date: dateText)
                    self.resultLabel.text = "Geliriniz başarıyla kaydedildi"
                } else {
                    self.resultLabel.text = "Lütfen bir tarih seçiniz"
                }
            } else {
                self.resultLabel.text = "Lütfen gelir miktarınızı giriniz"
            }
        }else{
            self.resultLabel.text = "Lütfen bir açıklama giriniz"
        }
        self.resultLabel.isHidden = false
    }
    
    @objc func chooseDate(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let date = dateFormatter.string(from: datePicker.date)
        dateOfIncomeTextField.text = date
        
    }
    
    @objc func touchSpace(){
        view.endEditing(true)
    }

}
