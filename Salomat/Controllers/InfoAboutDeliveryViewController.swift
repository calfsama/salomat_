//
//  InfoAboutDeliveryViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 13/10/22.
//

import UIKit

class InfoAboutDeliveryViewController: UIViewController {
    
    lazy var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var uiView2: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var uiView3: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var star: UILabel = {
        let label = UILabel()
        label.text = "*"
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var star2: UILabel = {
        let label = UILabel()
        label.text = "*"
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var star3: UILabel = {
        let label = UILabel()
        label.text = "*"
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var star4: UILabel = {
        let label = UILabel()
        label.text = "*"
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.text = "Имя Фамилия"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reqiered: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reqiered2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    lazy var phone: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.text = "Номер телефона"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.keyboardType = .phonePad
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
    
    lazy var additionalPhone: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.text = "Телефон, если мы не дозвонимся"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var additionalPTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .phonePad
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var street: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.text = "Улица"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var streetTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    lazy var house: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.text = "Дом"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var houseTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    lazy var referencePoint: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Ориентир"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var referencePointTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    lazy var comments: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "Комментарии"
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        configureConstraints()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardWillShow1(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
           if view.frame.origin.y == 0{
               let height = keyboardSize.height
               self.button.frame.origin.y += height
           }
       }
   }

    @objc func keyboardWillHide1(notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
           if view.frame.origin.y != 0 {
               let height = keyboardSize.height
               self.button.frame.origin.y -= height
           }
       }
   }
    
    func validate() {
        if streetTextField.text == "" && nameTextField.text == "" && houseTextField.text == "" && phoneTextField.text == ""{
            streetTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            phoneTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if nameTextField.text == "" && phoneTextField.text == "" && houseTextField.text == ""{
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            phoneTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if streetTextField.text == "" && phoneTextField.text == "" && houseTextField.text == ""{
            streetTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            phoneTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if streetTextField.text == "" && nameTextField.text == "" && houseTextField.text == ""{
            streetTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if phoneTextField.text == "" && nameTextField.text == "" {
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            phoneTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if phoneTextField.text == "" && houseTextField.text == "" {
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if houseTextField.text == "" && streetTextField.text == "" {
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            streetTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if nameTextField.text == "" && streetTextField.text == "" {
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
            streetTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if nameTextField.text == "" {
            nameTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if phoneTextField.text == "" {
            phoneTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if houseTextField.text == "" {
            houseTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
        else if streetTextField.text == "" {
            streetTextField.layer.borderColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1).cgColor
        }
    }
    
    func configureConstraints() {
        view.addSubview(uiView)
        view.addSubview(uiView2)
        view.addSubview(uiView3)
        view.addSubview(name)
        view.addSubview(nameTextField)
        view.addSubview(phone)
        view.addSubview(phoneTextField)
        view.addSubview(additionalPhone)
        view.addSubview(additionalPTextField)
        view.addSubview(street)
        view.addSubview(streetTextField)
        view.addSubview(house)
        view.addSubview(houseTextField)
        view.addSubview(referencePoint)
        view.addSubview(referencePointTextField)
        view.addSubview(comments)
        view.addSubview(commentsTextField)
        view.addSubview(button)
        view.addSubview(star)
        view.addSubview(star2)
        view.addSubview(star3)
        view.addSubview(star4)
        view.addSubview(reqiered)
        view.addSubview(reqiered2)
        
        NSLayoutConstraint.activate([
            
            uiView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uiView.heightAnchor.constraint(equalToConstant: 3),
            uiView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5),
            
            uiView2.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            uiView2.leadingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: 11),
            uiView2.heightAnchor.constraint(equalToConstant: 3),
            uiView2.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5),
            
            uiView3.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            uiView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            uiView3.heightAnchor.constraint(equalToConstant: 3),
            uiView3.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5),
            
            name.topAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            star.topAnchor.constraint(equalTo: name.topAnchor, constant: -3),
            star.leadingAnchor.constraint(equalTo: name.trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            phone.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            phone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            star2.topAnchor.constraint(equalTo: phone.topAnchor, constant: -3),
            star2.leadingAnchor.constraint(equalTo: phone.trailingAnchor),
            
            phoneTextField.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 10),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 45),
            
            reqiered2.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            reqiered2.leadingAnchor.constraint(equalTo: star2.trailingAnchor, constant: 5),
            
            additionalPhone.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 15),
            additionalPhone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            additionalPTextField.topAnchor.constraint(equalTo: additionalPhone.bottomAnchor, constant: 10),
            additionalPTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            additionalPTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            additionalPTextField.heightAnchor.constraint(equalToConstant: 45),
            
            street.topAnchor.constraint(equalTo: additionalPTextField.bottomAnchor, constant: 15),
            street.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            star3.topAnchor.constraint(equalTo: street.topAnchor, constant: -3),
            star3.leadingAnchor.constraint(equalTo: street.trailingAnchor),
            
            streetTextField.topAnchor.constraint(equalTo: street.bottomAnchor, constant: 10),
            streetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            streetTextField.trailingAnchor.constraint(equalTo: houseTextField.leadingAnchor, constant: -10),
            streetTextField.heightAnchor.constraint(equalToConstant: 45),
            
            house.topAnchor.constraint(equalTo: additionalPTextField.bottomAnchor, constant: 15),
            house.leadingAnchor.constraint(equalTo: streetTextField.trailingAnchor, constant: 10),
            
            star4.topAnchor.constraint(equalTo: house.topAnchor, constant: -3),
            star4.leadingAnchor.constraint(equalTo: house.trailingAnchor),
            
            houseTextField.topAnchor.constraint(equalTo: house.bottomAnchor, constant: 10),
            houseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            houseTextField.widthAnchor.constraint(equalToConstant: 55),
            houseTextField.heightAnchor.constraint(equalToConstant: 45),
            
            referencePoint.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 15),
            referencePoint.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            referencePointTextField.topAnchor.constraint(equalTo: referencePoint.bottomAnchor, constant: 10),
            referencePointTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            referencePointTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            referencePointTextField.heightAnchor.constraint(equalToConstant: 45),
            
            comments.topAnchor.constraint(equalTo: referencePointTextField.bottomAnchor, constant: 15),
            comments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            commentsTextField.topAnchor.constraint(equalTo: comments.bottomAnchor, constant: 10),
            commentsTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            commentsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            commentsTextField.heightAnchor.constraint(equalToConstant: 65),
            
            reqiered.topAnchor.constraint(equalTo: commentsTextField.bottomAnchor, constant: 5),
            reqiered.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func buttonAction() {
        if phoneTextField.text == "" || nameTextField.text == "" || streetTextField.text == "" || houseTextField.text == "" {
            reqiered.text = "Заполните обязательные поля"
            validate()
        }
        
        else if nameTextField.text != "" && phoneTextField.text != "" && streetTextField.text != "" && houseTextField.text != "" {
            if phoneTextField.text?.count ?? 0 < 9 {
                reqiered2.text = "Телефон должен состоять из 9 чисел"
            }
            else if phoneTextField.text?.count == 9 {
                let vc = InfoAboutDeliveryTwoViewController()
                vc.title = "Информация о доставке"
                vc.name = nameTextField.text!
                vc.phone_number = phoneTextField.text!
                vc.phone_number2 = additionalPTextField.text!
                vc.address = streetTextField.text! + " " + houseTextField.text! + " " + referencePointTextField.text!
                vc.comment = commentsTextField.text!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
