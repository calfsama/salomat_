//
//  BADCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 19/09/22.
//

import UIKit
import Kingfisher

class BADCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var navigationController: UINavigationController
    var vitamin: CategoriesForMainPage?
    var favorites: FavoritesData?
    
    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(MedicinesCollectionViewCell.self, forCellWithReuseIdentifier: MedicinesCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        layout.minimumLineSpacing = 16
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BADCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vitamin?.categories_for_main_page?[1].categ_prods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: MedicinesCollectionViewCell.identifier, for: indexPath) as! MedicinesCollectionViewCell
        
        cell.title.text = vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].product_name ?? ""
        cell.price.text = (vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].product_price)! + " сом."
        let url = "http://374315-ca17278.tmweb.ru/upload_product/"
        let completeURL = url + (vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].product_pic ?? "")
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: completeURL))
        if vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].is_favorite == false {
            cell.button.setImage(UIImage(named: "favorite"), for: .normal)
            }
        else if vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].is_favorite == true{
            cell.button.setImage(UIImage(named: "heart"), for: .normal)
            }
        cell.count = Int(vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].total_count_in_store ?? "") ?? 0
        cell.titleMedicine = vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].product_name ?? ""
        cell.prices = vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].product_price ?? ""
        cell.images = vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].product_pic ?? ""
        cell.is_favorite = ((vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].is_favorite) != nil)
        cell.id = vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].id ?? ""
        if favorites?[indexPath.row].id == vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].id {
            cell.button.setImage(UIImage(named: "heart"), for: .normal)
        }
        else {
            cell.button.setImage(UIImage(named: "favorite"), for: .normal)
        }
        cell.configureConstraints()
        cell.hideSkeleton()
        cell.startSkeletonAnimation()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.1 * 0.92, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AboutProductViewController()
        vc.id = vitamin?.categories_for_main_page?[1].categ_prods?[indexPath.row].id ?? ""
        self.navigationController.pushViewController(vc, animated: true)
    }
}
