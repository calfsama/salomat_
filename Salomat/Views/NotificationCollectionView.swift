//
//  NotificationCollectionView.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 22/11/22.
//

import UIKit
import Kingfisher

class NotificationCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var notification: NotificationData?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: layout)
        register(NotificationCollectionViewCell.self, forCellWithReuseIdentifier: NotificationCollectionViewCell.identifier)
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        var coll = CommentFlowLayout()
        collectionViewLayout = coll
        contentInsetAdjustmentBehavior = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension NotificationCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notification?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: NotificationCollectionViewCell.identifier, for: indexPath) as! NotificationCollectionViewCell
        cell.contentView.layer.borderColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1).cgColor
        cell.contentView.layer.borderWidth = 1
        cell.image.kf.setImage(with: URL(string: notification?[indexPath.row].image ?? ""))
        cell.title.text = notification?[indexPath.row].title ?? ""
        cell.subtitle.text = notification?[indexPath.row].body ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 400)
    }
}

final class CommentFlowLayout : UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
        layoutAttributesObjects?.forEach({ layoutAttributes in
            if layoutAttributes.representedElementCategory == .cell {
                if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                    layoutAttributes.frame = newFrame
                }
            }
        })
        return layoutAttributesObjects
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { fatalError() }
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        
        layoutAttributes.frame.origin.x = sectionInset.left
        layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
        return layoutAttributes
    }
}
