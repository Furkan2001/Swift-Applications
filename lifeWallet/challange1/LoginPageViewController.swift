//
//  LoginPageViewController.swift
//  challange1
//
//  Created by Furkan Ekinci on 1.09.2023.
//

import UIKit

final class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let username = UserDefaults.standard.string(forKey: "username") {
            usernameText.text = username
            if let password = UserDefaults.standard.string(forKey: "password"){
                passwordText.text = password
            }
        }

        resultLabel.isHidden = true
        passwordText.isSecureTextEntry = true
    }
    

    @IBAction func loginTouched(_ sender: Any) {
    
        if let username = usernameText.text, username != ""{
            if let password = passwordText.text, password != ""{
                if Usersdao().didUseThisUsernameBefore(username: username){
                    if Usersdao().didThisUserRegisterBefore(username: username, password: password){
                        /*let Main = UIStoryboard(name: "Main", bundle: nil)
                        if let realAppInit = Main.instantiateViewController(withIdentifier: "loginPageToRealAppInitVİewController") as? RealAppInitViewController{
                            self.navigationController?.pushViewController(realAppInit, animated: true)
                        }*/
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(username, forKey: "username")
                        userDefaults.set(password, forKey: "password")
                        performSegue(withIdentifier: "loginPageToRealAppInit", sender: nil)
                    }else{
                        resultLabel.text = "Girdiğiniz şifre hatalı"
                        resultLabel.isHidden = false
                    }
                }else{
                    resultLabel.text = "Bu Kullanıcı adı mevcut değil"
                    resultLabel.isHidden = false
                }
            }else{
                resultLabel.text = "Lütfen şifrenizi girin!"
                resultLabel.isHidden = false
            }
        }else{
            resultLabel.text = "Lütfen kullanıcı adınızı girin!"
            resultLabel.isHidden = false
        }
    }
    
    

}
