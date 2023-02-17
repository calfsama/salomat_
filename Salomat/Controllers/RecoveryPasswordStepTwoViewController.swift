//
//  RecoveryPasswordStepTwoViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 27/09/22.
//

import UIKit

class RecoveryPasswordStepTwoViewController: UIViewController {
    var phoneNumber: String = ""
    
    lazy var code: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Введите код из смс"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "_ _ _ _ "
        textField.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .phonePad
        textField.textAlignment = .center
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var repeatMessage: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.text = "Повторная отправка сообщения будет доступна через:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timer: UILabel = {
        let label = UILabel()
        label.text = "2:56"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cancel: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = .white
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(checkCode), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        apiService()
        configureConstraints()
        self.hideKeyboardWhenTappedAround()
    }
    
    func configureConstraints() {
        view.addSubview(code)
        view.addSubview(textField)
        view.addSubview(repeatMessage)
        view.addSubview(timer)
        view.addSubview(cancel)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            code.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            code.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: code.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.widthAnchor.constraint(equalToConstant: 330),
            
            repeatMessage.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            repeatMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            
            timer.topAnchor.constraint(equalTo: repeatMessage.bottomAnchor,constant: 16),
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cancel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            cancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancel.heightAnchor.constraint(equalToConstant: 45),
            cancel.widthAnchor.constraint(equalToConstant: 160),
            
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.leadingAnchor.constraint(equalTo: cancel.trailingAnchor, constant: 16),
            continueButton.heightAnchor.constraint(equalToConstant: 45),
            continueButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    @objc func buttonAction() {
        let vc = RecoveryPasswordStepThreeViewController()
        vc.title = "Восстановление пароля"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func checkCode() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/check_register_code") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "phone": phoneNumber,
            "confirm_code": textField.text!
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
                    
            else {
                print("errorrr", error ?? URLError(.badServerResponse))
                return
            }
            if response.statusCode >= 200 && response.statusCode <= 299 {
                DispatchQueue.main.async {
                    let vc = RecoveryPasswordStepThreeViewController()
                    vc.title = "Восстановление пароля"
                    vc.phone = self.phoneNumber
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else if response.statusCode == 400 {
                DispatchQueue.main.async {
                    //self.wrongPasswod.text = "Введен неверный пароль"
                    print(self.phoneNumber)
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
    
    func apiService() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/resend_sms") else { return }
        let parameters: [String: Any] = [
            "phone": phoneNumber
        ]
        ApiService.callPost(url: url, params: parameters, finish: finishPost)
    }
    
    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(Login.self, from: jsonData)
                print(parsedData)
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
}
