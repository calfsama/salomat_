//
//  RecoveryViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 26/09/22.
//

import UIKit

class RecoveryViewController: UIViewController {
    var phoneNumber: String = ""
    
    lazy var phone: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Телефон"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите свой номер"
        textField.text = phoneNumber
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.layer.cornerRadius = 4
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraints()
        self.hideKeyboardWhenTappedAround()
    }
    
    func configureConstraints() {
        view.addSubview(phone)
        view.addSubview(textField)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            phone.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            phone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.widthAnchor.constraint(equalToConstant: 330),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.heightAnchor.constraint(equalToConstant: 45),
            continueButton.widthAnchor.constraint(equalToConstant: 330),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func buttonAction() {
        let vc = RecoveryPasswordStepTwoViewController()
        vc.title = "Восстановление пароля"
        vc.phoneNumber = textField.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func login() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/check_phone") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "phone": textField.text!
        ]
        request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
                    
            else { //check for fundamental networking error
                print("errorrr", error ?? URLError(.badServerResponse))
                return
            }
            if response.statusCode >= 200 && response.statusCode <= 299 {
                let vc = RecoveryPasswordStepTwoViewController()
                DispatchQueue.main.async {
                    vc.title = "Восстановление пароля"
                    vc.phoneNumber = self.textField.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else if response.statusCode == 400 {
                DispatchQueue.main.async {
                    //self.wrongPasswod.text = "Введен неверный пароль"
                }
                
                print("error")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            }
            catch {
                print(error)
            }

            guard (200 ... 299) ~= response.statusCode else {                     //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
        }
        task.resume()
    }
}
