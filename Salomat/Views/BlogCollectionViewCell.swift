//
//  BlogCollectionViewCell.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 16/09/22.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell {
    static let identifier = "BlogCollectionViewCell"
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.font = UIFont(name: "NotoSans-Bold", size: 30)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.alpha = 0.9
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.font = UIFont(name: "NotoSans-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptions: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        label.font = UIFont(name: "NotoSans-Regular", size: 12)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("читать дальше", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    func configureConstraints() {
        contentView.addSubview(title)
        contentView.addSubview(date)
        contentView.addSubview(descriptions)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
          
            date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            descriptions.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 6),
            descriptions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            button.topAnchor.constraint(equalTo: descriptions.bottomAnchor, constant: 3),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
