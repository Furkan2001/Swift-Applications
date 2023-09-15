//
//  MyAccountViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 8.09.2023.
//

import UIKit

final class MyAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var username = String()
    private var user = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        resultLabel.isHidden = true
        if let name = UserDefaults.standard.string(forKey: "username") {
            self.username = name
        }
        
        self.user = Usersdao().returnUserInUsername(username: self.username)
        
        emailTextField.text = self.user.user_email
        usernameTextField.text = self.user.user_username
    }
    
    @IBAction func saveNewInformations(_ sender: Any) {
        
        if (!(passwordTextLabel.text != "" && emailTextField.text == self.user.user_email && usernameTextField.text == self.user.user_username)){
            if let email = emailTextField.text, isValidEmail(email: email) {
                if let username = usernameTextField.text, username.count > 8 {
                    if (passwordTextLabel.text != ""){
                        if let password = passwordTextLabel.text, password.count > 8 {
                            if Usersdao().didUseThisEmailBefore(email: email) {
                                if (emailTextField.text == self.user.user_email){
                                    if Usersdao().didUseThisUsernameBefore(username: username){
                                        if (usernameTextField.text == self.user.user_username){
                                            let userDefaults = UserDefaults.standard
                                            userDefaults.removeObject(forKey: "username")
                                            userDefaults.removeObject(forKey: "password")
                                            
                                            userDefaults.set(username, forKey: "username")
                                            userDefaults.set(password, forKey: "password")
                                            
                                            Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: password)
                                            
                                            resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                                        }else{
                                            resultLabel.text = "Bu kullanıcı adı daha önce kullanıldı!"
                                        }
                                    }else{
                                        let userDefaults = UserDefaults.standard
                                        userDefaults.removeObject(forKey: "username")
                                        userDefaults.removeObject(forKey: "password")
                                        
                                        userDefaults.set(username, forKey: "username")
                                        userDefaults.set(password, forKey: "password")
                                        
                                        Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: password)
                                        
                                        resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                                    }
                                }
                                else{
                                    resultLabel.text = "Bu email adresi daha önce kullanıldı!"
                                }
                            }else{
                                if Usersdao().didUseThisUsernameBefore(username: username){
                                    resultLabel.text = "Bu kullanıcı adı daha önce kullanıldı!"
                                }else{
                                    let userDefaults = UserDefaults.standard
                                    userDefaults.removeObject(forKey: "username")
                                    userDefaults.removeObject(forKey: "password")
                                    
                                    userDefaults.set(username, forKey: "username")
                                    userDefaults.set(password, forKey: "password")
                                    
                                    Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: password)
                                    
                                    resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                                }
                            }
                        }else{
                            resultLabel.text = "Şifre en az 9 karakter içermeli!"
                        }
                    }
                    else{
                        if Usersdao().didUseThisEmailBefore(email: email) {
                            if (emailTextField.text == self.user.user_email){
                                if Usersdao().didUseThisUsernameBefore(username: username){
                                    if (usernameTextField.text == self.user.user_username){
                                        let userDefaults = UserDefaults.standard
                                        userDefaults.removeObject(forKey: "username")
                                        userDefaults.removeObject(forKey: "password")
                                        
                                        Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: self.user.user_password!)
                                        
                                        resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                                    }else{
                                        resultLabel.text = "Bu kullanıcı adı daha önce kullanıldı!"
                                    }
                                }else{
                                    let userDefaults = UserDefaults.standard
                                    userDefaults.removeObject(forKey: "username")
                                    userDefaults.removeObject(forKey: "password")
                                    
                                    userDefaults.set(username, forKey: "username")
                                    userDefaults.set(self.user.user_password!, forKey: "password")
                                    
                                    Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: self.user.user_password!)
                                    
                                    resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                                }
                            }
                            else{
                                resultLabel.text = "Bu email adresi daha önce kullanıldı!"
                            }
                        }else{
                            if Usersdao().didUseThisUsernameBefore(username: username){
                                if (usernameTextField.text == self.user.user_username){
                                    let userDefaults = UserDefaults.standard
                                    userDefaults.removeObject(forKey: "username")
                                    userDefaults.removeObject(forKey: "password")
                                    
                                    userDefaults.set(username, forKey: "username")
                                    userDefaults.set(self.user.user_password!, forKey: "password")
                                    
                                    Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: self.user.user_password!)
                                    
                                    resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                                }else{
                                    resultLabel.text = "Bu kullanıcı adı daha önce kullanıldı!"
                                }
                            }else{
                                let userDefaults = UserDefaults.standard
                                userDefaults.removeObject(forKey: "username")
                                userDefaults.removeObject(forKey: "password")
                                
                                userDefaults.set(username, forKey: "username")
                                userDefaults.set(self.user.user_password!, forKey: "password")
                                
                                Usersdao().updateUserInUsername(dummyUsername: self.username, email: email, username: username, password: self.user.user_password!)
                                
                                resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
                            }
                        }
                    }
                }else{
                    resultLabel.text = "Kullanıcı adı en az 9 karakter içermeli!"
                }
            } else {
                resultLabel.text = "Girdiğiniz email geçersiz!"
            }
        }else{
            if let password = passwordTextLabel.text, password.count > 8 {
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: "username")
                userDefaults.removeObject(forKey: "password")
                
                userDefaults.set(username, forKey: "username")
                userDefaults.set(password, forKey: "password")
                
                Usersdao().updateUserInUsername(dummyUsername: self.username, email: self.user.user_email!, username: self.user.user_username!, password: password)
                resultLabel.text = "Tebrikler, Kayıt güncelleme Başarılı :)"
            }else{
                resultLabel.text = "Şifre en az 9 karakter içermeli!"
            }
        }
        resultLabel.isHidden = false
    }
    
    @IBAction func exitFromAccount(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "username")
        userDefaults.removeObject(forKey: "password")
        //exit(-1)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func isValidEmail(email: String) -> Bool {
            // E-posta doğrulama mantığını burada uygulayın
            // Örnek bir doğrulama işlevi:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
    }
    
}
