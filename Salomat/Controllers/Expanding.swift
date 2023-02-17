//
//  Expanding.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 22/12/22.
//

import UIKit
import KeychainAccess

class Expanding: UIViewController {
    var expand = ExpandingCollectionView()
    var network = NetworkService()
    let keychain = Keychain(service: "tj.info.Salomat")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        order()
        configureConstraints()
    }
    
    func configureConstraints() {
        view.addSubview(expand)
        
        NSLayoutConstraint.activate([
            expand.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            expand.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            expand.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            expand.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func order(){
        let urlString = "/products/user_orders/\(keychain["UserID"] ?? "")"
        self.network.order(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.expand.order = response
                print(result)
                self.expand.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
