//
//  GoodsCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 14/10/22.
//

import UIKit

class GoodsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var data = [Basket]()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: GoodsCollectionViewCell.identifier)
        register(SubtotalCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SubtotalCollectionReusableView.identifier)
        register(GoodsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GoodsHeaderCollectionReusableView.identifier)
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
extension GoodsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GoodsCollectionViewCell.identifier, for: indexPath) as! GoodsCollectionViewCell
        cell.medical.text = data[indexPath.row].title ?? ""
        cell.amount.text = (data[indexPath.row].amount ?? "") + "шт"
        cell.price.text = "\((Double(data[indexPath.row].amount ?? "") ?? 0) * (Double(data[indexPath.row].price ?? "") ?? 0))" + " сомони"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
             
         case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GoodsHeaderCollectionReusableView.identifier, for: indexPath) as! GoodsHeaderCollectionReusableView
            header.configure()
            return header
             
         case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SubtotalCollectionReusableView.identifier, for: indexPath) as! SubtotalCollectionReusableView
            footer.loadArticles()
            footer.layer.cornerRadius = 4
            footer.layer.borderWidth = 1
            footer.layer.borderColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 1).cgColor
            footer.configureConstraints()
            return footer
             
         default:
             assert(false, "Unexpected element kind")
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if data.count != 0 {
            return CGSize(width: collectionView.frame.size.width, height: 230)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if data.count != 0 {
            return CGSize(width: collectionView.frame.size.width, height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
}
