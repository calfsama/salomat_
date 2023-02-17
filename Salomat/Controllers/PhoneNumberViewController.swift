//
//  PhoneNumberViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 13/10/22.
//

import UIKit
import KeychainAccess

class PhoneNumberViewController: UIViewController {
    var phoneNumber: String = ""
    var userID: String = ""
    var personalInfo = PersonalInfoViewController()
    var login: LoginData?
    var token: String = ""
    var alert: UIAlertController!
    var keychain = Keychain(service: "tj.info.Salomat")
    var isExpand: Bool = false
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height - 150)
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
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Номер телефона"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "932 55 44 55"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.returnKeyType = .next
        textField.keyboardType = .phonePad
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = prefix
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor( UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(updatePhone), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Номер телефона"
        hideKeyboardWhenTappedAround()
        userShow()
        configureConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApperence(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(phone)
        scrollView.addSubview(textField)
        scrollView.addSubview(button)
        
        NSLayoutConstraint.activate([
            phone.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            phone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 10),
            textField.widthAnchor.constraint(equalToConstant: view.frame.size.width - 32),
            textField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            button.bottomAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.bottomAnchor, constant: -20),
            button.widthAnchor.constraint(equalToConstant: scrollView.frame.size.width - 32),
            button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func keyboardApperence(notification: NSNotification){
            if !isExpand{
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardHeight = keyboardFrame.cgRectValue.height
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + keyboardHeight)
                    let height = keyboardHeight
                    self.button.frame.origin.y -= height
                   
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
                    self.button.frame.origin.y += height
                }
                else{
                    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 250)
                }
                isExpand = false
            }
            
        }
    
    func userShow() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/show/\(keychain["UserID"] ?? "")") else { return }
        var request = URLRequest(url: url)
        request.setValue(keychain["Token"] ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
                    
            else {                                                                //check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(LoginData.self, from: data)
                DispatchQueue.main.async {
                    self.login = responseObject
                    self.textField.text = self.login?[0].login
                }
                print(responseObject)
            } catch {
                print(error) // parsing error
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }.resume()
    }
    
    func showAlert() {
        self.alert = UIAlertController(title: "", message: "Номер изменен", preferredStyle: UIAlertController.Style.alert)
        self.present(self.alert, animated: true, completion: nil)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }

    @objc func dismissAlert(){
        // Dismiss the alert from here
        self.alert.dismiss(animated: true, completion: nil)
    }
    
    @objc func updatePhone() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/update_user/\(keychain["UserID"] ?? "")") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "login": textField.text!,
            "comfirm": 0 ,
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
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
            else if response.statusCode == 400 {
                DispatchQueue.main.async {
                  print("errrooor")
                }

                print("user doesn't exist")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json, "first")
            }
            catch {
                print(error, "second")
            }
        }
        task.resume()
    }
}
