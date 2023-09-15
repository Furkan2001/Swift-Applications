//
//  AddNewBooksViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class AddNewBooksViewController: UIViewController {
    
    @IBOutlet weak var nameOfBookTextField: UITextField!
    @IBOutlet weak var numberOfPageTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateTextField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(chooseDate(datePicker:)), for: .valueChanged)
        
        let touchToSpace = UITapGestureRecognizer(target: self, action: #selector(touchSpace))
        
        self.view.addGestureRecognizer(touchToSpace)
        self.resultLabel.isHidden = true
    }
    
    
    @IBAction func addNewBookToDatabase(_ sender: Any) {
        
        if let name = nameOfBookTextField.text, name.count > 0{
            if let number = numberOfPageTextField.text, let intValue = Int(number) {
                if let dateText = dateTextField.text, !dateText.isEmpty {
                    Bookdao().addNewBook(user_id: UserDefaults.standard.integer(forKey: "user_id"), book_name: name, book_page: intValue, date: dateText)
                    self.resultLabel.text = "Kitabınız başarıyla kaydedildi"
                } else {
                    self.resultLabel.text = "Lütfen bir tarih seçiniz"
                }
            } else {
                self.resultLabel.text = "Lütfen sayfa sayısını giriniz"
            }
        }else{
            self.resultLabel.text = "Lütfen bir isim giriniz"
        }
        self.resultLabel.isHidden = false
    }
    
    @objc func chooseDate(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let date = dateFormatter.string(from: datePicker.date)
        dateTextField.text = date
        
    }
    
    @objc func touchSpace(){
        view.endEditing(true)
    }
    
}
