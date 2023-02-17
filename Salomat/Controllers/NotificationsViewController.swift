//
//  NotificationsViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 22/11/22.
//

import UIKit

class NotificationsViewController: UIViewController {
    var notificationCollectionView = NotificationCollectionView()
    var news = NotificationNewsCollectionView()
    var network = NetworkService()
    
    lazy var notificationButton: UIButton = {
        var button = UIButton()
        button.setTitle("Уведомления", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(changeScroll2), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.235, green: 0.902, blue: 0.51, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var notificationScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = view.bounds
        scroll.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height - 100)
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    lazy var newsButton: UIButton = {
        var button = UIButton()
        button.setTitle("Новости", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var newsScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = view.bounds
        scroll.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    lazy var header: UIView = {
        let header = UIView()
        header.backgroundColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchNotifications()
        configure()
    }
    
    func conf() {
        view.addSubview(notificationScroll)
        notificationScroll.addSubview(notificationButton)
        notificationScroll.addSubview(newsButton)
        notificationScroll.addSubview(notificationCollectionView)
        
        NSLayoutConstraint.activate([
            
            notificationButton.topAnchor.constraint(equalTo: notificationScroll.topAnchor, constant: 20),
            notificationButton.leadingAnchor.constraint(equalTo: notificationScroll.leadingAnchor, constant: 16),
            notificationButton.heightAnchor.constraint(equalToConstant: 20),
            notificationButton.widthAnchor.constraint(equalToConstant: 100),
            
            newsButton.topAnchor.constraint(equalTo: notificationScroll.topAnchor,constant: 20),
            newsButton.leadingAnchor.constraint(equalTo: notificationButton.trailingAnchor, constant: 5),
            newsButton.widthAnchor.constraint(equalToConstant: 100),
            newsButton.heightAnchor.constraint(equalToConstant: 20),
            
            notificationCollectionView.topAnchor.constraint(equalTo: newsButton.bottomAnchor, constant: 20),
            notificationCollectionView.leadingAnchor.constraint(equalTo: notificationScroll.leadingAnchor),
            notificationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notificationCollectionView.bottomAnchor.constraint(equalTo: notificationScroll.bottomAnchor)
            
        ])
    }
    
    func configure() {
        view.addSubview(notificationScroll)
        notificationScroll.addSubview(notificationButton)
        notificationScroll.addSubview(newsButton)
        notificationScroll.addSubview(uiView)
        notificationScroll.addSubview(notificationCollectionView)
        newsButton.setTitleColor(UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1), for: .normal)
        notificationButton.setTitleColor(UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1), for: .normal)
        
        NSLayoutConstraint.activate([
            
            notificationButton.topAnchor.constraint(equalTo: notificationScroll.topAnchor, constant: 20),
            notificationButton.leadingAnchor.constraint(equalTo: notificationScroll.leadingAnchor, constant: 16),
            notificationButton.heightAnchor.constraint(equalToConstant: 20),
            notificationButton.widthAnchor.constraint(equalToConstant: 130),
            
            newsButton.topAnchor.constraint(equalTo: notificationScroll.topAnchor,constant: 20),
            newsButton.leadingAnchor.constraint(equalTo: notificationButton.trailingAnchor, constant: 5),
            newsButton.widthAnchor.constraint(equalToConstant: 100),
            newsButton.heightAnchor.constraint(equalToConstant: 20),
            
            uiView.topAnchor.constraint(equalTo: notificationButton.bottomAnchor, constant: 10),
            uiView.leadingAnchor.constraint(equalTo: notificationButton.leadingAnchor),
            uiView.heightAnchor.constraint(equalToConstant: 3),
            uiView.widthAnchor.constraint(equalToConstant: 130),
            
            notificationCollectionView.topAnchor.constraint(equalTo: newsButton.bottomAnchor, constant: 20),
            notificationCollectionView.leadingAnchor.constraint(equalTo: notificationScroll.leadingAnchor),
            notificationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notificationCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNotifications(){
        let urlString = "/PushNotification"
        let host = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.network.notif(urlString: host) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.notificationCollectionView.notification = response
                print(result)
                self.notificationCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }

    
    func congifureScroll() {
        view.addSubview(newsScroll)
        newsScroll.addSubview(notificationButton)
        newsScroll.addSubview(newsButton)
        newsScroll.addSubview(uiView)
        newsButton.setTitleColor(UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1), for: .normal)
        notificationButton.setTitleColor(UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1), for: .normal)
        
        NSLayoutConstraint.activate([
            
            notificationButton.topAnchor.constraint(equalTo: newsScroll.topAnchor, constant: 20),
            notificationButton.leadingAnchor.constraint(equalTo: newsScroll.leadingAnchor, constant: 16),
            notificationButton.heightAnchor.constraint(equalToConstant: 20),
            notificationButton.widthAnchor.constraint(equalToConstant: 130),
            
            newsButton.topAnchor.constraint(equalTo: newsScroll.topAnchor,constant: 20),
            newsButton.leadingAnchor.constraint(equalTo: notificationButton.trailingAnchor, constant: 5),
            newsButton.widthAnchor.constraint(equalToConstant: 100),
            newsButton.heightAnchor.constraint(equalToConstant: 20),
            
            uiView.topAnchor.constraint(equalTo: newsButton.bottomAnchor, constant: 10),
            uiView.leadingAnchor.constraint(equalTo: newsButton.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: newsButton.trailingAnchor),
            uiView.heightAnchor.constraint(equalToConstant: 3),
            
            news.topAnchor.constraint(equalTo: newsButton.bottomAnchor, constant: 20),
            news.leadingAnchor.constraint(equalTo: newsScroll.leadingAnchor),
            news.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            news.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func changeScroll() {
        congifureScroll()
    }
    
    @objc func changeScroll2() {
        configure()
    }
    // upload image in API
}
