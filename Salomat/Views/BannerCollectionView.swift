//
//  BannerCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 02/09/22.
//

import UIKit
import Kingfisher
import SkeletonView

class BannerCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var banners: MainSliders?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 16
        backgroundColor = .white
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BannerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.main_slider?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        let url = "http://374315-ca17278.tmweb.ru/upload_banner/"
        let completeURL = url + (banners?.main_slider?[indexPath.row].slider_pic ?? "")
        cell.image.downloaded(from: completeURL)
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: completeURL))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.92, height: 170)
    }
}
