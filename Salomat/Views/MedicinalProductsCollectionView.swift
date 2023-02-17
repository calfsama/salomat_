//
//  MedicinalProductsCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 16/09/22.
//

import UIKit
import Kingfisher

class MedicinalProductsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var navigationController: UINavigationController
    var favorites: FavoritesData?
    var categories: CategoriesForMainPage?
    
    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(MedicinesCollectionViewCell.self, forCellWithReuseIdentifier: MedicinesCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 16
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MedicinalProductsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.categories_for_main_page?[0].categ_prods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: MedicinesCollectionViewCell.identifier, for: indexPath) as! MedicinesCollectionViewCell
     
        cell.title.text = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_name ?? ""
        cell.price.text = (categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_price)! + " сом."
        let url = "http://374315-ca17278.tmweb.ru/upload_product/"
        let completeURL = url + (categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_pic ?? "")
        cell.count = Int(categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].total_count_in_store ?? "") ?? 0
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: completeURL))
        if favorites?[indexPath.row].id == categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].id {
            cell.button.setImage(UIImage(named: "heart"), for: .normal)
        }
        else {
            cell.button.setImage(UIImage(named: "favorite"), for: .normal)
        }
        cell.titleMedicine = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_name ?? ""
        cell.prices = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_price ?? ""
        cell.images = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_pic ?? ""
        cell.is_favorite = ((categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].is_favorite) != nil)
        cell.id = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].id ?? ""
        cell.configureConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.1 * 0.92, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AboutProductViewController()
        vc.title = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].product_name ?? ""
        vc.id = categories?.categories_for_main_page?[0].categ_prods?[indexPath.row].id ?? ""
        self.navigationController.pushViewController(vc, animated: true)

    }
}

