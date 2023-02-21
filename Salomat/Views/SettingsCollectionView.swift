//
//  SettingsCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/10/22.
//

extension String {
    var html2Attributed: NSAttributedString? {
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html]
        do {
            guard let data = data(using: String.Encoding.unicode) else {
                return nil
            }
            return try NSMutableAttributedString(data: data ?? Data(),
                                          options: options,
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

import UIKit
import SwiftKeychainWrapper
import KeychainAccess

class SettingsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var navigationController: UINavigationController
    var settings = [Settings]()
    var userID: String = ""
    var token: String = ""
    var phone: String = ""
    let keychain = Keychain(service: "tj.info.Salomat")

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 0
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func set(cells: [Settings]) {
            self.settings = cells
        }
}
extension SettingsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.identifier, for: indexPath) as! SettingsCollectionViewCell
        cell.parametr.text = settings[indexPath.row].title
        cell.image.image = UIImage(named: settings[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            let vc = PersonalInfoViewController()
            vc.title = "Личная информация"
            vc.userID = userID
            vc.token = token
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let vc = NotificationsViewController()
            vc.title = "Уведомления и новости"
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3 {
            let vc = Expanding()
            vc.title = "Мои заказы"
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4 {
            let vc = PhoneNumberViewController()
            vc.title = "Номер телефона"
            vc.userID = userID
            vc.token = token
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5 {
            let vc = SafetyViewController()
            vc.title = "Безопасность"
            vc.phone = phone
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 6 {
            let token = KeychainWrapper.standard.removeObject(forKey: "ttoken")
            keychain["UserID"] = ""
            let reg = MainTabBarViewController()
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = reg
        }
    }
}
