//
//  AddNewExpenseViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class AddNewExpenseViewController: UIViewController {

    @IBOutlet weak var descriptionOfExpenseTextField: UITextField!
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var dateOfExpenseTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateOfExpenseTextField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(chooseDate(datePicker:)), for: .valueChanged)
        
        let touchToSpace = UITapGestureRecognizer(target: self, action: #selector(touchSpace))
        
        self.view.addGestureRecognizer(touchToSpace)
        self.resultLabel.isHidden = true
    }
    
    
    @IBAction func addNewExpenseToDatabase(_ sender: Any) {
        
        if let description = descriptionOfExpenseTextField.text, description.count > 0{
            if let text = expenseTextField.text, let floatValue = Float(text) {
                if let dateText = dateOfExpenseTextField.text, !dateText.isEmpty {
                    Expensedao().addNewExpense(team_id: UserDefaults.standard.integer(forKey: "team_id"), user_id: UserDefaults.standard.integer(forKey: "user_id"), expense_description: description, expense: floatValue, date: dateText)
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
        dateOfExpenseTextField.text = date
        
    }
    
    @objc func touchSpace(){
        view.endEditing(true)
    }

}
