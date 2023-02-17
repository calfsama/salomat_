//
//  RegisterStepTwoViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/10/22.
//

import UIKit

class RegisterStepTwoViewController: UIViewController {
    var condition: Bool = false
    var phone: String = ""
    var alert: UIAlertController!
    
    lazy var password: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
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
    
    lazy var repeatPassword: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.text = "Повторный пароль"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите повторно пароль"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
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
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye closed"), for: .normal)
        button.addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondEyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye closed"), for: .normal)
        button.addTarget(self, action: #selector(secondEyeButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var register: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(registration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var agree: UILabel = {
        let label = UILabel()
        label.text = "Нажав на кнопку “Продолжить”, я принимаю"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor =  UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var usl: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1), for: .normal)
        button.setTitle("условия пользования", for: .normal)
        button.addTarget(self, action: #selector(termsOfUse), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var match: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func termsOfUse() {
        let vc = TermsOfUseViewController()
        self.present(vc, animated: true)
    }
    
    @objc func eyeButtonAction() {
        if condition == false {
            condition = true
            eyeButton.setImage(UIImage(named: "Group"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
        else if condition == true {
            condition = false
            eyeButton.setImage(UIImage(named: "eye closed"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func secondEyeButtonAction() {
        if condition == false {
            condition = true
            secondEyeButton.setImage(UIImage(named: "Group 1"), for: .normal)
            repeatPasswordTextField.isSecureTextEntry = false
        }
        else if condition == true {
            condition = false
            secondEyeButton.setImage(UIImage(named: "eye closed"), for: .normal)
            repeatPasswordTextField.isSecureTextEntry = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraints()
        self.hideKeyboardWhenTappedAround()
    }
    
    func configureConstraints() {
        view.addSubview(password)
        view.addSubview(passwordTextField)
        view.addSubview(eyeButton)
        view.addSubview(repeatPassword)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(secondEyeButton)
        view.addSubview(cancel)
        view.addSubview(register)
        view.addSubview(agree)
        view.addSubview(usl)
        view.addSubview(match)
        
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            passwordTextField.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.widthAnchor.constraint(equalToConstant: 330),
            
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -20),
            
            repeatPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor,constant: 5),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 45),
            repeatPasswordTextField.widthAnchor.constraint(equalToConstant: 330),
            
            secondEyeButton.centerYAnchor.constraint(equalTo: repeatPasswordTextField.centerYAnchor),
            secondEyeButton.trailingAnchor.constraint(equalTo: repeatPasswordTextField.trailingAnchor, constant: -20),
            
            match.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 5),
            match.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            agree.bottomAnchor.constraint(equalTo: usl.topAnchor),
            agree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            agree.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usl.bottomAnchor.constraint(equalTo: cancel.topAnchor, constant: -20),
            usl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cancel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            cancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancel.heightAnchor.constraint(equalToConstant: 45),
            cancel.widthAnchor.constraint(equalToConstant: 160),
            
            register.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            register.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            register.leadingAnchor.constraint(equalTo: cancel.trailingAnchor, constant: 16),
            register.heightAnchor.constraint(equalToConstant: 45),
            register.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func showAlert() {
        self.alert = UIAlertController(title: "", message: "Пользователь успешно зарегистрирован", preferredStyle: UIAlertController.Style.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }

    @objc func dismissAlert(){
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
        let v = ProfileViewController()
        v.title = "Вход"
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    @objc func buttonAction() {
        let vc = ProfileViewController()
        vc.title = "Вход или регистрация"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func registration() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/register") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "phone": phone,
            "password": passwordTextField.text!
        ]
        if passwordTextField.text == repeatPasswordTextField.text && passwordTextField.text?.count ?? 0 >= 8 {
            request.httpBody = parameters.percentEncoded()
        }
        else if passwordTextField.text?.count ?? 0 <= 7 {
            passwordTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            match.text = "Пароль должен содержать не менее 8 символов"
        }
        else if repeatPasswordTextField.text == "" {
            passwordTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            match.text = "Заполните поле"
        }
        else if repeatPasswordTextField.text != passwordTextField.text {
            match.text = "Пароли не совпадают"
            passwordTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
                    
            else { //check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.showAlert()
                }
                print("Registration completed successfully!")
            }
            else if response.statusCode == 400 {
                DispatchQueue.main.async {
                }
                print("user doesn't exist")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            }
            catch {
                print(error)
            }
         
        
            guard (200 ... 299) ~= response.statusCode else { //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
        }
        task.resume()
    }
}
