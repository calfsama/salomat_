//
//  CategoriesForMainPageTwoCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 24/10/22.
//

import UIKit

class CategoriesForMainPageTwoCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var category: CategoriesProducts?
    var index: IndexPath?
    var id: String = ""
    var navigationController: UINavigationController
    

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(CategoriesForMainPageCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesForMainPageCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CategoriesForMainPageTwoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.category?.sub_cat.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CategoriesForMainPageCollectionViewCell.identifier, for: indexPath) as! CategoriesForMainPageCollectionViewCell
        cell.button.setImage(UIImage(named: "arrow"), for: .normal)
        cell.category.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        cell.category.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cell.category.text = category?.category?.sub_cat[indexPath.row].category_name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MainCategoriesViewController()
        vc.id = category?.category?.sub_cat[indexPath.row].id ?? ""
        vc.title = category?.category?.sub_cat[indexPath.row].category_name ?? ""
        self.navigationController.pushViewController(vc, animated: true)
    }
}
