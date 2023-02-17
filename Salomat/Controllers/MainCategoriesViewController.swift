//
//  MainCategoriesViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 10/01/23.
//

import UIKit

class MainCategoriesViewController: UIViewController {
    var network = NetworkService()
    var id: String = ""
    var medicinesCollectionView: MainCategoriesCollectionView!
    var spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        medicinesCollectionView = MainCategoriesCollectionView(nav: self.navigationController!)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        spinner.color = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        spinner.frame = CGRect(x: 165, y: 280, width: 40, height: 40)
        fetchFromApi()
        configureConstraints()
    }
    
    func configureConstraints() {
        view.addSubview(medicinesCollectionView)
        
        NSLayoutConstraint.activate([
            medicinesCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            medicinesCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            medicinesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func fetchFromApi(){
        self.view.addSubview(spinner)
        spinner.stopAnimating()
        let urlString = "/categories/products/\(id)"
        self.network.mainCategories(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.medicinesCollectionView.categories = response
                print(result)
                self.medicinesCollectionView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
