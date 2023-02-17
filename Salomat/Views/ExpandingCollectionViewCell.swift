//
//  ExpandingCollectionViewCell.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 22/12/22.
//

import UIKit

class ExpandingCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExpandingCollectionViewCell"
    
    lazy var condition: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1).cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var id: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var data: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 1, alpha: 1).cgColor
        configureConstraints()
    }
    
    func configureConstraints() {
        contentView.addSubview(id)
        contentView.addSubview(condition)
        contentView.addSubview(data)
        contentView.addSubview(arrowButton)
        
        NSLayoutConstraint.activate([
            //id.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            id.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            id.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            condition.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            condition.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            condition.leadingAnchor.constraint(equalTo: id.trailingAnchor, constant: 20),
            condition.widthAnchor.constraint(equalToConstant: 100),
            
            data.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            data.leadingAnchor.constraint(equalTo: condition.trailingAnchor, constant: 20),
            
            arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
