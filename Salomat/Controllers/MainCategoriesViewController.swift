//
//  MainCategoriesViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 10/01/23.
//

import UIKit

class MainCategoriesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var network = NetworkService()
    var categories: CategoriesProducts?
    var pageNumber: Int = 1
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
        medicinesCollectionView.delegate = self
        medicinesCollectionView.dataSource = self
        fetchFromApi(page: 1)
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
    func fetchFromApi(page: Int){
        self.view.addSubview(spinner)
        spinner.stopAnimating()
        let urlString = "/categories/products/\(id)?page=\(page)"
        self.network.mainCategories(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.categories = response
                print(result)
                self.medicinesCollectionView.reloadData()
                self.spinner.stopAnimating()
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
extension MainCategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.category_products?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicinesCollectionViewCell.identifier, for: indexPath) as! MedicinesCollectionViewCell
        cell.count = Int(categories?.category_products?.products[indexPath.row].total_count_in_store ?? "") ?? 0
        cell.title.text = categories?.category_products?.products[indexPath.row].product_name ?? ""
        cell.id = categories?.category_products?.products[indexPath.row].id ?? ""
        cell.is_favorite = ((categories?.category_products?.products[indexPath.row].is_favorite) != nil)
        cell.titleMedicine = categories?.category_products?.products[indexPath.row].product_name ?? ""
        cell.prices = categories?.category_products?.products[indexPath.row].product_price ?? ""
        cell.images = categories?.category_products?.products[indexPath.row].product_pic ?? ""
        cell.title.text = categories?.category_products?.products[indexPath.row].product_name ?? ""
        cell.price.text = categories?.category_products?.products[indexPath.row].product_price ?? ""
        let url = "http://slomat2.colibri.tj/upload_product/"
        let completeURL = url + (categories?.category_products?.products[indexPath.row].product_pic ?? "")
        cell.image.downloaded(from: completeURL)
        cell.configureConstraints()
        return cell
    }
    
    @objc func empty() {
        print("don't work")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.3, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AboutProductViewController()
        vc.title = categories?.category_products?.products[indexPath.row].product_name ?? ""
        vc.id = categories?.category_products?.products[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageNumber < 5 && indexPath.row == (categories?.category_products?.products.count ?? 0) - 1 {
            pageNumber = pageNumber + 1
            fetchFromApi(page: pageNumber)
        }
    }
}
