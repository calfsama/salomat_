//
//  CategoriesViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 06/10/22.
//

import UIKit

class CategoriesViewController: UIViewController {
    var categoriesCollectionView: CategoriesCollectionView!
    var network = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchFromAPI()
        categoriesCollectionView = CategoriesCollectionView(nav: self.navigationController!)
        configureConstraints()
    }
    
    func configureConstraints() {
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            categoriesCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
    }
    
    func fetchFromAPI() {
        let urlString = "/products/categories_for_main_page?"
        self.network.fetchFromApi(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.categoriesCollectionView.categories = response
                print(result)
                self.categoriesCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
