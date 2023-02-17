//
//  MyOrdersCollectionReusableView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 21/10/22.
//

import UIKit

class MyOrdersCollectionReusableView: UICollectionReusableView {
    static let identifier = "MyOrdersCollectionReusableView"
    
    lazy var priceOfGoods: UILabel = {
        let label = UILabel()
        label.text = "Стоимость товара:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceOfDelivery: UILabel = {
        let label = UILabel()
        label.text = "Стоимость доставки:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.text = "215 сом"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var delivery: UILabel = {
        let label = UILabel()
        label.text = "10 сом"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalCount: UILabel = {
        let label = UILabel()
        label.text = "Итого:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var total: UILabel = {
        let label = UILabel()
        label.text = "225 сом"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitle("Повторить заказ", for: .normal)
        button.setTitleColor( UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func configure() {
        backgroundColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 0.2)
        addSubview(priceOfGoods)
        addSubview(price)
        addSubview(priceOfDelivery)
        addSubview(delivery)
        addSubview(total)
        addSubview(button)
        addSubview(totalCount)
        
        NSLayoutConstraint.activate([
            priceOfGoods.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            priceOfGoods.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            price.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            price.leadingAnchor.constraint(equalTo: priceOfGoods.trailingAnchor, constant: 8),
            
            priceOfDelivery.topAnchor.constraint(equalTo: priceOfGoods.bottomAnchor, constant: 15),
            priceOfDelivery.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            delivery.topAnchor.constraint(equalTo: priceOfGoods.bottomAnchor, constant: 15),
            delivery.leadingAnchor.constraint(equalTo: priceOfDelivery.trailingAnchor, constant: 8),
            
            total.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 15),
            total.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            totalCount.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 15),
            totalCount.trailingAnchor.constraint(equalTo: total.leadingAnchor, constant: -10),
        
            button.topAnchor.constraint(equalTo: priceOfDelivery.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 45)
        
        ])
    }
}
