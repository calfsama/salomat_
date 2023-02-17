//
//  BlogShowViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 13/12/22.
//

import UIKit
import Kingfisher

class BlogShowViewController: UIViewController {
    var network = NetworkService()
    var show: Show?
    var id: String = ""
    var indicator = UIActivityIndicatorView()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 3200)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var blogTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.numberOfLines = 0
        title.alpha = 0.9
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var date: UILabel = {
        let date = UILabel()
        date.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        date.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    lazy var share: UILabel = {
        let share = UILabel()
        share.textColor = UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        share.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        share.translatesAutoresizingMaskIntoConstraints = false
        return share
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        subtitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        subtitle.numberOfLines = 0
        subtitle.alpha = 0.9
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.addSubview(indicator)
        scrollView.bringSubviewToFront(indicator)
        indicator.frame = CGRect(x: 180, y: 300, width: 40, height: 40)
        indicator.color = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        indicator.startAnimating()
        fetchBlogData()
        configureConstraints()
    }
    
    func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(blogTitle)
        scrollView.addSubview(date)
        scrollView.addSubview(share)
        scrollView.addSubview(image)
        scrollView.addSubview(subtitle)
        
        NSLayoutConstraint.activate([
            blogTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            blogTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            blogTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
            date.topAnchor.constraint(equalTo: blogTitle.bottomAnchor, constant: 20),
            date.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),

            share.topAnchor.constraint(equalTo: blogTitle.bottomAnchor, constant: 20),
            share.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            image.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 16),
            image.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 360),
            image.heightAnchor.constraint(equalToConstant: 200),

            subtitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            subtitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            subtitle.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            subtitle.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
    
    func fetchBlogData(){
        let urlString = "/blogs/blog?blog_id=\(id)"
        self.network.show(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.show = response
                self.blogTitle.text = self.show?.blog?.blog_title ?? ""
                let url = "http://374315-ca17278.tmweb.ru/upload_blog/"
                let completeURL = url + (self.show?.blog?.blog_pics?[0].blog_pic ?? "")
                self.image.kf.indicatorType = .activity
                self.image.kf.setImage(with: URL(string: completeURL))
                self.date.text = self.show?.blog?.blog_date ?? ""
                self.subtitle.attributedText = self.show?.blog?.blog_about?.html2Attributed
                self.share.text = "Поделиться"
                self.indicator.stopAnimating()
                print(result)
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
