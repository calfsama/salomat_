//
//  FavoritesViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import CoreData
import KeychainAccess

class FavoritesViewController: UIViewController {
    var network = NetworkService()
    var favoriteCollectionView: FavoriteCollectionView!
    var collection = GoodsCollectionView()
    let keychain = Keychain(service: "tj.info.Salomat")
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fav")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
        favoriteCollectionView = FavoriteCollectionView(nav: self.navigationController!)
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites()
    }
    
    func configure() {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
        
            image.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        
        ])
    }
    
    func configureConstraints() {
        view.addSubview(favoriteCollectionView)
        
        NSLayoutConstraint.activate([
            favoriteCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            favoriteCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height)
        ])
    }
    
    func favorites(){
        let urlString = "/favorites?user_id=\(keychain["UserID"] ?? "")"
        self.network.favorites(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.favoriteCollectionView.favorites = response
                self.favoriteCollectionView.reloadData()
                self.configureConstraints()
            case .failure(let error):
                print("error", error)
                self.configure()
            }
        }
    }
}
