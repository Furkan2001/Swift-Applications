//
//  LoginPageViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 1.09.2023.
//

import UIKit

final class RegisteredPageViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    
    @IBOutlet weak var resultStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultStateLabel.isHidden = true
        passwordText.isSecureTextEntry = true
        passwordAgainText.isSecureTextEntry = true
        

    }
    

    func isValidEmail(email: String) -> Bool {
            // E-posta doğrulama mantığını burada uygulayın
            // Örnek bir doğrulama işlevi:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
    }
   
    @IBAction func loginTouched(_ sender: Any) {
        
        if let email = emailText.text, isValidEmail(email: email) {
            if let username = usernameText.text, username.count > 8{
                if let password = passwordText.text, password.count > 8{
                    if let passAgain = passwordAgainText.text, passAgain == password{
                        if Usersdao().didUseThisEmailBefore(email: email) {
                            resultStateLabel.text = "Bu email adresi daha önce kullanıldı!"
                        }else{
                            if Usersdao().didUseThisUsernameBefore(username: username){
                                resultStateLabel.text = "Bu kullanıcı adı daha önce kullanıldı!"
                            }else{
                                Usersdao().addNewUser(user_email: email, user_username: username, user_password: password)
                                resultStateLabel.text = "Tebrikler, Kaydınız Başarılı :)"
                            }
                        }
                    }else{
                        resultStateLabel.text = "Şifreleriniz aynı olmak zorundadır!"
                    }
                }else{
                    resultStateLabel.text = "Şifre en az 9 karakter içermeli!"
                }
            }else{
                resultStateLabel.text = "Kullanıcı adı en az 9 karakter içermeli!"
            }
        } else {
            resultStateLabel.text = "Girdiğiniz email geçersiz!"
        }
        resultStateLabel.isHidden = false
    }
    
}
