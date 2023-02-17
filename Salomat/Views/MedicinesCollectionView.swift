//
//  MedicinesCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import Kingfisher

class MedicinesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var navigationController: UINavigationController
    var cell = MedicinesCollectionViewCell()
    var sales: Sales?

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
extension MedicinesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sales?.total_products?.total_prods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: MedicinesCollectionViewCell.identifier, for: indexPath) as! MedicinesCollectionViewCell
        cell.count = Int(sales?.total_products?.total_prods?[indexPath.row].total_count_in_store ?? "") ?? 0
        cell.id = sales?.total_products?.total_prods?[indexPath.row].id ?? ""
        cell.is_favorite = ((sales?.total_products?.total_prods?[indexPath.row].is_favorite) != nil)
        cell.titleMedicine = sales?.total_products?.total_prods?[indexPath.row].product_name ?? ""
        cell.prices = sales?.total_products?.total_prods?[indexPath.row].product_price ?? ""
        cell.images = sales?.total_products?.total_prods?[indexPath.row].product_pic ?? ""
        cell.title.text = sales?.total_products?.total_prods?[indexPath.row].product_name ?? ""
        cell.price.text = sales?.total_products?.total_prods?[indexPath.row].product_price ?? ""
        let url = "http://374315-ca17278.tmweb.ru/upload_product/"
        let completeURL = url + (sales?.total_products?.total_prods?[indexPath.row].product_pic ?? "")
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: completeURL))
        cell.configureConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.3, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AboutProductViewController()
        vc.id = sales?.total_products?.total_prods?[indexPath.row].id ?? ""
        self.navigationController.pushViewController(vc, animated: true)
        
    }
}
