//
//  LoginController.swift
//  MarketApp
//
//  Created by Mikayil on 06.01.25.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var logintext: UIButton!
    var users = [User]()
    var useradapter = UserAdapter()
    let maneger = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        cornerRadius()
        useradapter.readDate { usersData in
            self.users = usersData
        }
            emailtext.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            passwordtext.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    
    func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.frame = CGRect(x: 20, y: 50, width: 50, height: 30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.view.addSubview(backButton)
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
        func cornerRadius() {
            logintext.layer.cornerRadius = 20
            passwordtext.layer.cornerRadius = 20
            emailtext.layer.cornerRadius = 20
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            if textField.text?.isEmpty == true {
                textField.backgroundColor = UIColor.white
            } else if textField == emailtext {
                if isValidEmail(emailtext.text) {
                    emailtext.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
                } else {
                    emailtext.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
                }
            } else if textField == passwordtext {
                // Şifrə yoxlanışı
                if isValidPassword(passwordtext.text) {
                    passwordtext.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
                } else {
                    passwordtext.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
                }
            }
        }
        
        
        func isValidEmail(_ email: String?) -> Bool {
            guard let email = email else { return false }
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        
        func isValidPassword(_ password: String?) -> Bool {
            guard let password = password else { return false }
            return password.count >= 6
        }
        
        @IBAction func loginButton(_ sender: Any) {
            let emailValid = isValidEmail(emailtext.text)
            let passwordValid = isValidPassword(passwordtext.text)
            
            if emailValid && passwordValid {
                showAlert(title: "Uğur", message: "Giriş uğurla tamamlandı!")
            } else {
                showAlert(title: "Xəta", message: "E-mail və ya şifrə yanlışdır!")
            }
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
                        sceneDelegate.tabRoot()
                        maneger.setValue(value: true, key: .isLoggedIn)
        }
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    


