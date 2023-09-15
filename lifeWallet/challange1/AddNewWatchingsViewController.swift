//
//  AddNewWatchingsViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 10.09.2023.
//

import UIKit

final class AddNewWatchingsViewController: UIViewController {
    
    @IBOutlet weak var nameOfWatchingTextField: UITextField!
    @IBOutlet weak var typeOfWatchingTextField: UITextField!
    @IBOutlet weak var timeForWatchingTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var datePicker : UIDatePicker?
    private var filmType : [FilmType]?
    private var pickerView : UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateTextField.inputView = datePicker
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        typeOfWatchingTextField.inputView = pickerView
        
        datePicker?.addTarget(self, action: #selector(chooseDate(datePicker:)), for: .valueChanged)
        
        let touchToSpace = UITapGestureRecognizer(target: self, action: #selector(touchSpace))
        
        self.view.addGestureRecognizer(touchToSpace)
        self.resultLabel.isHidden = true
        
        let toolBar = UIToolbar()
        toolBar.tintColor = .magenta
        toolBar.sizeToFit()
        
        let okayButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(okayFunction))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(cancelFunction))
        
        toolBar.setItems([cancelButton, spaceButton, okayButton], animated: true)
        
        typeOfWatchingTextField.inputAccessoryView = toolBar
        
        //------------------------------------------------------------
        filmType = FilmTypedao().selectAllElements()
        //------------------------------------------------------------
    }
    
    @IBAction func addNewWatchingToDatabase(_ sender: Any) {
        
        if let name = nameOfWatchingTextField.text, name.count > 0{
            if let type = typeOfWatchingTextField.text, type.count > 0{
                if let number = timeForWatchingTextField.text, let intValue = Int(number) {
                    if let dateText = dateTextField.text, !dateText.isEmpty {
                        let type_id = FilmTypedao().findTheIdFromName(name: type)
                        Filmdao().addNewFilm(user_id: UserDefaults.standard.integer(forKey: "user_id"), film_type_id: type_id, film_name: name, film_time: intValue, date: dateText)
                        self.resultLabel.text = "Kitabınız başarıyla kaydedildi"
                    } else {
                        self.resultLabel.text = "Lütfen bir tarih seçiniz"
                    }
                } else {
                    self.resultLabel.text = "Lütfen sayfa sayısını giriniz"
                }
            } else{
                self.resultLabel.text = "Lütfen bir tür seçiniz"
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
    
    @objc func okayFunction(){
        self.view.endEditing(true)
    }
    
    @objc func cancelFunction(){
        typeOfWatchingTextField.text = ""
        self.view.endEditing(true)
    }

}

extension AddNewWatchingsViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filmType!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filmType![row].type_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeOfWatchingTextField.text = filmType![row].type_name
    }
}
