//
//  InfoCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/10/22.
//

import UIKit

class InfoCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var info = [Info]()
    var navigationController: UINavigationController
    
    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 20
        contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        backgroundColor = .white
    }
    func set(cells: [Info]) {
        self.info = cells
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension InfoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.identifier, for: indexPath) as! InfoCollectionViewCell
        cell.image.image = info[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let v = AboutProjectWebViewController()
            v.title = "О проекте"
            self.navigationController.pushViewController(v, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = HowToMakeAnOrderViewController()
            vc.title = "Доставка и оплата"
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let vc = ShippingAndPaymentViewController()
            vc.title = "Как сделать заказ"
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}
