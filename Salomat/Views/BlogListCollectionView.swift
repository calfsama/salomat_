//
//  BlogListCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 19/09/22.
//

import UIKit

class BlogListCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var navigationController: UINavigationController
    var blogs: Blog?
    
    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(BlogListCollectionViewCell.self, forCellWithReuseIdentifier: BlogListCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        layout.minimumLineSpacing = 0
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BlogListCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogs?.content?.blogs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: BlogListCollectionViewCell.identifier, for: indexPath) as! BlogListCollectionViewCell
        cell.title.text = blogs?.content?.blogs?[indexPath.row].blog_title ?? ""
        cell.date.text = blogs?.content?.blogs?[indexPath.row].blog_created_at ?? ""
        let url = "http://374315-ca17278.tmweb.ru/upload_blog/"
        let completeURL = url + (blogs?.content?.blogs?[indexPath.row].blog_pic ?? "")
        cell.image.downloaded(from: completeURL)
        cell.image.image = UIImage(named: "3")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BlogShowViewController()
        vc.title = "Блог"
        vc.id = blogs?.content?.blogs?[indexPath.row].id ?? ""
        self.navigationController.pushViewController(vc, animated: true)
    }
}
