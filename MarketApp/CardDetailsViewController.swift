//
//  CardDetailsViewController.swift
//  MarketApp
//
//  Created by Mikayil on 19.01.25.
//
import UIKit


class CardDetailsViewController: UIViewController, UITextFieldDelegate {
    private let cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Card Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 20)
        textField.addTarget(self, action: #selector(cardNumberTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private let expiryDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Expiry Date"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20)
        textField.addTarget(self, action: #selector(expiryDateTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.autocapitalizationType = .words
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20)
        textField.addTarget(self, action: #selector(fullNameTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private let cvcTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "CVC"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 20)
        textField.addTarget(self, action: #selector(cvcTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private let frontCardImageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.image = UIImage(named: "card")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private let backCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "card2")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cardNumberLabel: UILabel = {
        let n = UILabel()
        n.textColor = .white
        n.font = UIFont.boldSystemFont(ofSize: 18)
        n.text = "**** **** **** ****"
        n.translatesAutoresizingMaskIntoConstraints = false
        return n
    }()
    
    private let fullNameLabel: UILabel = {
        let f = UILabel()
        f.textColor = .white
        f.font = UIFont.boldSystemFont(ofSize: 18)
        f.text = "**** *****"
        f.numberOfLines = 0
        f.translatesAutoresizingMaskIntoConstraints = false
        return f
    }()
    
    private let expiryDateLabel: UILabel = {
        let e = UILabel()
        e.textColor = .white
        e.font = UIFont.boldSystemFont(ofSize: 12)
        e.text = "**/**"
        e.textAlignment = .left
        e.translatesAutoresizingMaskIntoConstraints = false
        e.numberOfLines = 0
        return e
    }()
    
    private let cvcLabel: UILabel = {
        let c = UILabel()
        c.textColor = .white
        c.font = UIFont.boldSystemFont(ofSize: 12)
        c.text = "***"
        c.textAlignment = .left
        c.numberOfLines = 0
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    private let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 28
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment"
        view.backgroundColor = .white
        fullNameTextField.delegate = self
        cardNumberTextField.delegate = self
        setupLayout()
        
    }
    @objc func payButtonTapped() {
        // Payment logic here
        print("Payment button tapped")
    }


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fullNameTextField {
            if string.isEmpty {
                return true
            }
            let allowedCharacters = CharacterSet.letters.union(.whitespaces)
            let filtered = string.rangeOfCharacter(from: allowedCharacters)
            return filtered != nil
        } else if textField == cardNumberTextField {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            return newLength <= 19
        } else if textField == cvcTextField {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            return newLength <= 3
        } else if textField == expiryDateTextField {
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            return newLength <= 5
        }
        return true
    }
   
    func setupLayout() {
        view.addSubview(cardView)
           view.addSubview(stackView)
           
           [cardNumberTextField, expiryDateTextField, fullNameTextField, cvcTextField, cardView].forEach {
               view.addSubview($0)
           }
           
           cardView.addSubview(frontCardImageView)
           cardView.addSubview(backCardImageView)
           backCardImageView.addSubview(cardNumberLabel)
           backCardImageView.addSubview(fullNameLabel)
           backCardImageView.addSubview(expiryDateLabel)
           backCardImageView.addSubview(cvcLabel)
           
           [cardNumberTextField, fullNameTextField, expiryDateTextField, cvcTextField].forEach {
               $0.translatesAutoresizingMaskIntoConstraints = false
           }
           
           
           stackView.addArrangedSubview(cardNumberTextField)
           stackView.addArrangedSubview(fullNameTextField)
           stackView.addArrangedSubview(expiryDateTextField)
           stackView.addArrangedSubview(cvcTextField)
              stackView.addArrangedSubview(payButton)

       
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
                   cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                   cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                   cardView.heightAnchor.constraint(equalToConstant: 200),
                   
                   frontCardImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
                   frontCardImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                   frontCardImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                   frontCardImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
                   
                   backCardImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
                   backCardImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                   backCardImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                   backCardImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
                   
                   stackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30),
                   stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                   stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardNumberLabel.leadingAnchor.constraint(equalTo: backCardImageView.leadingAnchor, constant: 10),
            cardNumberLabel.centerYAnchor.constraint(equalTo: backCardImageView.centerYAnchor, constant: -20),
            
            fullNameLabel.leadingAnchor.constraint(equalTo: backCardImageView.leadingAnchor, constant: 10),
            fullNameLabel.centerYAnchor.constraint(equalTo: backCardImageView.centerYAnchor, constant: 15),
            
            expiryDateLabel.leadingAnchor.constraint(equalTo: backCardImageView.leadingAnchor, constant: 93),
            expiryDateLabel.centerYAnchor.constraint(equalTo: backCardImageView.centerYAnchor, constant: 51),
            
            cvcLabel.centerXAnchor.constraint(equalTo: backCardImageView.centerXAnchor, constant: 8),
            cvcLabel.centerYAnchor.constraint(equalTo: backCardImageView.centerYAnchor, constant: 50)
        ])
    }
    
    @objc func cardNumberTextFieldChanged() {
        if let text = cardNumberTextField.text {
            let formattedText = formatCardNumber(text)
            cardNumberTextField.text = formattedText
            cardNumberLabel.text = formattedText
            flipCardAnimation()
        }
    }

    @objc func cvcTextFieldChanged() {
        if let text = cvcTextField.text {
            let filteredText = text.filter { $0.isNumber }
            if filteredText.count <= 3 {
                cvcTextField.text = filteredText
                cvcLabel.text = filteredText
            } else {
                cvcTextField.text = String(filteredText.prefix(3))
                cvcLabel.text = String(filteredText.prefix(3))
            }
        }
    }

    @objc func expiryDateTextFieldChanged() {
        if let text = expiryDateTextField.text {
            let cleanText = text.filter { "0123456789".contains($0) }
            if cleanText.count > 2 {
                let month = cleanText.prefix(2)
                let year = cleanText.suffix(from: cleanText.index(cleanText.startIndex, offsetBy: 2))
                expiryDateTextField.text = "\(month)/\(year)"
            } else {
                expiryDateTextField.text = cleanText
            }
            if expiryDateTextField.text?.count ?? 0 > 5 {
                expiryDateTextField.text = String(expiryDateTextField.text?.prefix(5) ?? "")
            }
            expiryDateLabel.text = expiryDateTextField.text
        }
    }

    @objc func fullNameTextFieldChanged() {
        if let text = fullNameTextField.text, !text.isEmpty {
            let capitalizedText = text.capitalized
            fullNameTextField.text = capitalizedText
        }
        fullNameLabel.text = fullNameTextField.text
    }
   
    func formatCardNumber(_ text: String) -> String {
        let digits = text.filter { $0.isNumber }
        var formattedString = ""
        for (index, digit) in digits.enumerated() {
            if index != 0 && index % 4 == 0 {
                formattedString.append(" ")
            }
            formattedString.append(digit)
        }
        return formattedString
    }

    func flipCardAnimation() {
        UIView.transition(from: frontCardImageView, to: backCardImageView, duration: 0.5, options: .transitionFlipFromLeft) { _ in
            self.frontCardImageView.isHidden = true
            self.backCardImageView.isHidden = false
        }
    }
}
