//
//  SignUpController.swift
//  MarketApp
//
//  Created by Mikayil on 06.01.25.
//

import UIKit

class SignUpController: UIViewController {
    @IBOutlet weak var fullnametext: UITextField!
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var signuptext: UIButton!
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
            fullnametext.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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

        func cornerRadius(){
            signuptext.layer.cornerRadius = 20
            emailtext.layer.cornerRadius = 20
            passwordtext.layer.cornerRadius = 20
            fullnametext.layer.cornerRadius = 20
        }
        @objc func textFieldDidChange(_ textField: UITextField) {
            if textField.text?.isEmpty == true {
                textField.backgroundColor = UIColor.white // Boş mətn üçün standart rəng
            } else if textField == fullnametext {
                if isValidFullName(fullnametext.text) {
                    fullnametext.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1) // Açıq yaşıl
                } else {
                    fullnametext.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1) // Açıq qırmızı
                }
            } else if textField == emailtext {
                if isValidEmail(emailtext.text) {
                    emailtext.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1) // Açıq yaşıl
                } else {
                    emailtext.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1) // Açıq qırmızı
                }
            } else if textField == passwordtext {
                if isValidPassword(passwordtext.text) {
                    passwordtext.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1) // Açıq yaşıl
                } else {
                    passwordtext.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1) // Açıq qırmızı
                }
            }
        }
    
        func isValidFullName(_ fullName: String?) -> Bool {
            guard let fullName = fullName else { return false }
            return fullName.count >= 8
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
        
        @IBAction func signUpButon(_ sender: Any) {
            let isNameValid = isValidFullName(fullnametext.text)
            let isEmailValid = isValidEmail(emailtext.text)
            let isPasswordValid = isValidPassword(passwordtext.text)
            if isNameValid && isEmailValid && isPasswordValid {
            } else {
                showAlert(title: "Xəta", message: "Məlumatları düzgün daxil edin.")
            }
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
                        sceneDelegate.tabRoot()
                        maneger.setValue(value: true, key: .isLoggedIn)
        }
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    
    

