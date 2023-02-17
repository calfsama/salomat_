//
//  ExpandingCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 22/12/22.
//

import UIKit

class ExpandingCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var condition: Bool = false
    var order: OrdersData?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        register(ExpandingCollectionViewCell.self, forCellWithReuseIdentifier: ExpandingCollectionViewCell.identifier)
        register(MyOrdersCollectionViewCell.self, forCellWithReuseIdentifier: MyOrdersCollectionViewCell.identifier)
        register(MyOrdersCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MyOrdersCollectionReusableView.identifier)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ExpandingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if order?.count == 0 {
            var emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            emptyLabel.text = "Нет заказов"
            emptyLabel.textColor = .gray
            emptyLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            emptyLabel.textAlignment = NSTextAlignment.center
            collectionView.backgroundView = emptyLabel
            //collectionView.separatorStyle = .none
            return 0
        }
        else {
            return order?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if condition == true {
            return (order?[section].products.count ?? 0) + 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = dequeueReusableCell(withReuseIdentifier: ExpandingCollectionViewCell.identifier, for: indexPath) as! ExpandingCollectionViewCell
            cell.id.text = order?[indexPath.section].order?.id ?? ""
            cell.condition.setTitle(order?[indexPath.section].status[0].status_text ?? "", for: .normal)
            cell.data.attributedText = order?[indexPath.section].order?.created_at?.html2Attributed
            
            if condition == true {
                cell.arrowButton.setImage(UIImage(named: "Vector"), for: .normal)
            }
            else if condition == false {
                cell.arrowButton.setImage(UIImage(named: "arrow-right"), for: .normal)
            }
            return cell
        }
        else {
            let cell = dequeueReusableCell(withReuseIdentifier: MyOrdersCollectionViewCell.identifier, for: indexPath) as! MyOrdersCollectionViewCell
            //cell.id.text = order?[indexPath.section].products[indexPath.row - 1].id ?? ""
            cell.medical.text = order?[indexPath.section].products[indexPath.row - 1].product_name ?? ""
            cell.count.text = order?[indexPath.section].products[indexPath.row - 1].total_count ?? ""
            cell.price.text = order?[indexPath.section].products[indexPath.row - 1].product_price ?? ""
            let url = "http://slomat2.colibri.tj/upload_product/"
            let completeURL = url + (order?[indexPath.section].products[indexPath.row - 1].product_pic ?? "")
            cell.image.downloaded(from: completeURL)
//            cell.condition.setTitle(order?[indexPath.section].status[0].status_text ?? "", for: .normal)
//            cell.data.attributedText = order?[indexPath.section].order?.created_at?.html2Attributed
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if condition == true && indexPath.row > 0 {
            return CGSize(width: collectionView.frame.size.width, height: 80)
        }
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MyOrdersCollectionReusableView.identifier, for: indexPath) as! MyOrdersCollectionReusableView
        if condition == true {
            footer.configure()
            footer.price.text = String((Double(order?[indexPath.section].order?.total_price ?? "") ?? 0) - (Double(order?[indexPath.section].delivery[indexPath.row].delivery_price ?? "") ?? 0)) + " сом"
            footer.delivery.text = String(Double(order?[indexPath.section].delivery[indexPath.row].delivery_price ?? "") ?? 0) + " сом"
            footer.total.text = (String(Double(order?[indexPath.section].order?.total_price ?? "") ?? 0)) + " сом"
        }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if condition == true {
            return CGSize(width: collectionView.frame.size.width, height: 140)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && condition == true {
            condition = false
            let sections = IndexSet.init(integer: indexPath.section)
            collectionView.reloadSections(sections)
        }
        else if indexPath.row == 0 && condition == false{
            condition = true
            let sections = IndexSet.init(integer: indexPath.section)
            collectionView.reloadSections(sections)
        }
    }
}
