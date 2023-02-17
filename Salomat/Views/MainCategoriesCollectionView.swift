//
//  MainCategoriesCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 10/01/23.
//

import UIKit

class MainCategoriesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var categories: CategoriesProducts?
    var navigationController: UINavigationController

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(MedicinesCollectionViewCell.self, forCellWithReuseIdentifier: MedicinesCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        layout.minimumLineSpacing = 16
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MainCategoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.category_products?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: MedicinesCollectionViewCell.identifier, for: indexPath) as! MedicinesCollectionViewCell
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
        self.navigationController.pushViewController(vc, animated: true)
    }
}
