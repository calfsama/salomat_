//
//  ProfileInfoViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/10/22.
//

import UIKit
import KeychainAccess

class ProfileInfoViewController: UIViewController {
    var token: String = ""
    var userID: String = ""
    var phone: String = ""
    var login: LoginData?
    let keychain = Keychain(service: "tj.info.Salomat")
    
    
    lazy var uiscrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 720)
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.text = "Имя не указано"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var email: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Почта не указана"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var infoCollectionView: InfoCollectionView!
    var settingsCollectionView: SettingsCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let keychain = Keychain(service: "com.tomirisnegmatova.Salomat")
//        print("hahaahh", keychain["UserID"] ?? "")
        navigationItem.title = "Профиль"
        view.addSubview(uiscrollView)
        navigationItem.backBarButtonItem?.target = nil
        navigationItem.backBarButtonItem?.action = #selector(exitFromProfile)
        navigationItem.backBarButtonItem?.style = .plain
        infoCollectionView = InfoCollectionView(nav: self.navigationController!)
        settingsCollectionView = SettingsCollectionView(nav: self.navigationController!)
        configureConstraints()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        settingsCollectionView.layer.cornerRadius = 30
        settingsCollectionView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        settingsCollectionView.layer.borderWidth = 1
        settingsCollectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        settingsCollectionView.layer.shadowOpacity = 3
        settingsCollectionView.layer.shadowRadius = 8
        settingsCollectionView.layer.shadowOffset = CGSize(width: 0, height: -3)
        infoCollectionView.set(cells: Info.items())
        settingsCollectionView.set(cells: Settings.items())
        print(userID, "1", token)
        settingsCollectionView.userID = userID
        settingsCollectionView.token = token
        settingsCollectionView.phone = phone
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let keychain = Keychain(service: "tj.info.Salomat")
        print("hahaahh", keychain["UserID"] ?? "")
        userShow()
    }
    
    func configureConstraints() {
        uiscrollView.addSubview(name)
        uiscrollView.addSubview(email)
        uiscrollView.addSubview(infoCollectionView)
        uiscrollView.addSubview(settingsCollectionView)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: uiscrollView.topAnchor, constant: 30),
            name.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor, constant: 16),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            email.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor, constant: 16),
            
            infoCollectionView.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 30),
            infoCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            infoCollectionView.heightAnchor.constraint(equalToConstant: 330),
            
            settingsCollectionView.topAnchor.constraint(equalTo: infoCollectionView.bottomAnchor),
            settingsCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            settingsCollectionView.heightAnchor.constraint(equalToConstant: 350)
        
        ])
    }
    func userShow() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/users/show/\(keychain["UserID"] ?? "")") else { return }
        var request = URLRequest(url: url)
        request.setValue(keychain["Token"] ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(self.keychain["Token"] ?? "")
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
            
            do {
                let responseObject = try JSONDecoder().decode(LoginData.self, from: data)
                DispatchQueue.main.async {
                    self.login = responseObject
                    self.name.text = self.login?[0].name ?? "Имя не указано"
                    self.email.text = self.login?[0].email ?? "Почта не указана"
                }
                print(responseObject)
            } catch {
                print(error)
        
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }.resume()
    }
    @objc func exitFromProfile() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
