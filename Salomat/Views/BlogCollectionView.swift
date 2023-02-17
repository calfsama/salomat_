//
//  BlogCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 16/09/22.
//

import UIKit

class BlogCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var navigationController: UINavigationController
    var blogs: Blog?

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(BlogCollectionViewCell.self, forCellWithReuseIdentifier: BlogCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BlogCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: BlogCollectionViewCell.identifier, for: indexPath) as! BlogCollectionViewCell
        let data = blogs?.content?.blogs?[indexPath.row]
        cell.title.text = data?.blog_title ?? ""
        cell.date.text = data?.blog_created_at ?? ""
        cell.descriptions.text = data?.blog_about ?? ""
        cell.descriptions.attributedText = data?.blog_about?.html2Attributed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let v = BlogShowViewController()
        v.title = "Блог"
        v.id = blogs?.content?.blogs?[indexPath.row].id ?? ""
        self.navigationController.pushViewController(v, animated: true)
    }
}
