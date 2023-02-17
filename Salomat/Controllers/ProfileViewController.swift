//
//  ProfileViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    var login: LoginData?
    var network = NetworkService()
    var alert: UIAlertController!
    var isLoggedIn: Bool = false
    var isExpand: Bool = false
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 3200)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var  prefix: UILabel = {
        let label = UILabel()
        label.text = "  +992 "
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.sizeToFit()
        return label
    }()
   
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
        textField.placeholder = "987654321"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.returnKeyType = .next
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.leftViewMode = .always
        textField.keyboardType = .phonePad
        textField.leftView = prefix
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
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
        button.setTitle("Войти или зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(checkPhone), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var match: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Вход"
        configureConstraints()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApperence(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardApperence(notification: NSNotification){
            if !isExpand{
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardHeight = keyboardFrame.cgRectValue.height
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + keyboardHeight)
                    let height = keyboardHeight
                    self.continueButton.frame.origin.y -= height
                }
                else{
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 250)
                }
                isExpand = true
            }
        }
        @objc func keyboardDisappear(notification: NSNotification){
            if isExpand{
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardHeight = keyboardFrame.cgRectValue.height
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - keyboardHeight)
                    let height = keyboardHeight
                    self.continueButton.frame.origin.y += height
                }
                else{
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 250)
                }
                isExpand = false
            }
            
        }
    
    func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(phone)
        scrollView.addSubview(textField)
        scrollView.addSubview(match)
        scrollView.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            phone.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor, constant: 16),
            phone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 5),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            match.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            match.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            continueButton.heightAnchor.constraint(equalToConstant: 45),
            continueButton.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.bottomAnchor, constant: -10),
        ])
    }
    
    @objc func postRequestButton() {
        let url = URL(string: "http://374315-ca17278.tmweb.ru/users/check_phone")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "phone": "\(textField)"
        ]
        request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else { // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else { // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(CheckPhone.self, from: data)
                print(responseObject)
            } catch {
                print(error) // parsing error
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        task.resume()
    }
    
    func showAlert() {
        self.alert = UIAlertController(title: "", message: "Пароль изменен", preferredStyle: UIAlertController.Style.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }

    @objc func dismissAlert(){
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkPhone() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/check_phone") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "phone": textField.text!
        ]
        
        if textField.text != "" {
            request.httpBody = parameters.percentEncoded()
        }
        else if textField.text == "" {
            self.match.text = "Введите номер телефона"
            self.textField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
     
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
                    
            else {  //check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    let vc = PasswordViewController()
                    vc.phone = self.textField.text!
                    vc.title = "Вход"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else if response.statusCode == 400 {
                DispatchQueue.main.async {
                    if self.textField.text != "" {
                        let vc = RegisterViewController()
                        vc.phone = self.textField.text!
                        vc.title = "Регистрация"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                print("user doesn't exist")
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json, "first")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
