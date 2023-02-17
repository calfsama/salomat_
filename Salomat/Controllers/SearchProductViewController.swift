//
//  SearchProductViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/12/22.
//

import UIKit
import SwiftUI
import Kingfisher

class SearchProductViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var collectionView: SearchCollectionView!
    var network = NetworkService()
    var search: Search?
    var searchController = UISearchController()
    var searchProduct: String = ""
    var popularCondition: Bool = false
    var notPopularCondition: Bool = false
    
    struct Constants {
        static let backgroundAlphaTo:  CGFloat = 0.6
    }
    
    let slider = DoubledSlider()
    
    private var myTargetView: UIView?
    
    lazy var minPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var maxPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Создание объектов
    let spinner = UIActivityIndicatorView()
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    lazy var notPopularButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(named: "Radiobutton 1"), for: .normal)
        button.addTarget(self, action: #selector(actionForNotPopularButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var popularButton: UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(named: "Radiobutton 1"), for: .normal)
        //button.addTarget(self, action: #selector(actionForPopularButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bottomSheet: UIView = {
        let myNewView = UIView(frame: CGRect(x: 0, y: 470, width: view.frame.size.width, height: view.frame.size.height))
        myNewView.backgroundColor = .white
        myNewView.layer.cornerRadius = 10
        return myNewView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Результаты"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var empty: UILabel = {
        let label = UILabel()
        label.text = "Пусто"
        label.textColor =  UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView = SearchCollectionView(nav: self.navigationController!)
        slider.minimumValue = 1
        slider.maximumValue = 200
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchCollectionReusableView.identifier)
        spinner.color = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        spinner.frame = CGRect(x: 160, y: 350, width: 40, height: 40)
        configure()
        setup()
        setuoLogo()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name:NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func actionForPopularButton() {
        if popularCondition == false {
            popularCondition = true
            notPopularCondition = false
            notPopularButton.setImage(UIImage(named: "Radiobutton 1"), for: .normal)
            popularButton.setImage(UIImage(named: "Radiobutton 2"), for: .normal)
            print("Find popular")
        }
        else if popularCondition == true {
            popularCondition = false
            popularButton.setImage(UIImage(named: "Radiobutton 1"), for: .normal)
        }
    }
    
    @objc func actionForNotPopularButton() {
        if notPopularCondition == false {
            notPopularCondition = true
            popularCondition = false
            popularButton.setImage(UIImage(named: "Radiobutton 1"), for: .normal)
            notPopularButton.setImage(UIImage(named: "Radiobutton 2"), for: .normal)
            print("Find not popular")
        }
        else if notPopularCondition == true {
            notPopularCondition = false
            notPopularButton.setImage(UIImage(named: "Radiobutton 1"), for: .normal)
        }
    }
    
    func configure() {
        view.addSubview(empty)
        NSLayoutConstraint.activate([
            empty.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            empty.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didChangeSliderValue() {
        print(self.slider.values.minimum)
        print(self.slider.values.maximum)
        minPrice.text = "\(Int(slider.values.minimum))"
        maxPrice.text = "\(Int(slider.values.maximum))"
    }
    
    func showFilter(on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(bottomSheet)
        lazy var uiview: UIView = {
            let uiview = UIView()
            uiview.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
            uiview.layer.cornerRadius = 4
            uiview.translatesAutoresizingMaskIntoConstraints = false
            return uiview
        }()
        
        lazy var price: UILabel = {
            let label = UILabel()
            label.text = "Цена"
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var raiting: UILabel = {
            let label = UILabel()
            label.text = "Рейтинг"
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var popular: UILabel = {
            let label = UILabel()
            label.text = "популярные"
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var notPopular: UILabel = {
            let label = UILabel()
            label.text = "непопулярные"
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var showButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
            button.setTitle("Показать", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.layer.cornerRadius = 4
            
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        // Constraints
        
        minPrice.text = "\(Int(slider.minimumValue))"
        maxPrice.text = "\(Int(slider.maximumValue))"
        slider.values.minimum = 1
        slider.values.maximum = 200
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
        showButton.addTarget(self, action: #selector(searchProducts), for: .touchUpInside)
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.bottomSheet.frame =  CGRect(x:0, y: 470, width: Int(self.view.frame.width), height: Int(self.view.frame.height));
                })
            }
            
        })
        
        bottomSheet.addSubview(uiview)
        bottomSheet.addSubview(price)
        bottomSheet.addSubview(slider)
        bottomSheet.addSubview(raiting)
        bottomSheet.addSubview(popularButton)
        bottomSheet.addSubview(popular)
        bottomSheet.addSubview(notPopularButton)
        bottomSheet.addSubview(notPopular)
        bottomSheet.addSubview(showButton)
        bottomSheet.addSubview(minPrice)
        bottomSheet.addSubview(maxPrice)
        
        
        NSLayoutConstraint.activate([
            uiview.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 5),
            uiview.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor),
            uiview.heightAnchor.constraint(equalToConstant: 5),
            uiview.widthAnchor.constraint(equalToConstant: 100),
            
            price.topAnchor.constraint(equalTo: uiview.bottomAnchor, constant: 20),
            price.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 16),
            
            minPrice.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 27),
            minPrice.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 16),
            
            maxPrice.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 27),
            maxPrice.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -16),
            
            slider.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 20),
            slider.leadingAnchor.constraint(equalTo: minPrice.trailingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: maxPrice.leadingAnchor, constant: -10),
            
            raiting.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 25),
            raiting.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 16),
            
            popularButton.topAnchor.constraint(equalTo: raiting.bottomAnchor, constant: 20),
            popularButton.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 16),
            popularButton.heightAnchor.constraint(equalToConstant: 20),
            popularButton.widthAnchor.constraint(equalToConstant: 20),
            
            popular.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 5),
            popular.topAnchor.constraint(equalTo: raiting.bottomAnchor, constant: 20),
            
            notPopularButton.topAnchor.constraint(equalTo: raiting.bottomAnchor, constant: 20),
            notPopularButton.leadingAnchor.constraint(equalTo: popular.trailingAnchor, constant: 25),
            notPopularButton.heightAnchor.constraint(equalToConstant: 20),
            notPopularButton.widthAnchor.constraint(equalToConstant: 20),
            
            notPopular.topAnchor.constraint(equalTo: raiting.bottomAnchor, constant: 20),
            notPopular.leadingAnchor.constraint(equalTo: notPopularButton.trailingAnchor, constant: 5),
            
            showButton.topAnchor.constraint(equalTo: notPopular.bottomAnchor, constant: 40),
            showButton.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor, constant: 16),
            showButton.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -16),
            showButton.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
    }
    
    @objc func showBottomSheet() {
        showFilter(on: self)
    }
    
    func dismissBottomSheet() {
        guard let targetView = myTargetView else { return }
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomSheet.frame = CGRect(x: 0, y: targetView.frame.size.height, width: targetView.frame.size.width, height: 300)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        self.bottomSheet.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        
                    }
                })
            }
        })
    }
    
    @objc func searchProducts() {
        let urlString = "/search/with_price?srch_pr_inp=\(searchProduct)&min_price=\(slider.values.minimum)&max_price=\(slider.values.maximum)"
        print(searchProduct)
        let host = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.network.search(urlString: host) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.search = response
                self.collectionView.reloadData()
                self.configureConstraints()
                print(self.search ?? "controller collection view", "kfnek")
            case .failure(let error):
                print("error", error)
            }
        }
        dismissBottomSheet()
    }
    
    @objc func loadList(notification: NSNotification){
        self.collectionView.reloadData()
    }
    
    // Вставка логотипа
    func setuoLogo() {
        let logo = UIImage(named: "logo 2")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    // Создание поиска
    func setup() {
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    // Констрейнты
    func configureConstraints() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
extension SearchProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.collectionView.addSubview(spinner)
        self.configureConstraints()
        spinner.startAnimating()
        let urlString = "/search/?srch_pr_inp=\(searchBar.text!)"
        let host = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        self.network.search(urlString: host) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.searchProduct = searchBar.text!
                self.search = response
                self.collectionView.reloadData()
                self.spinner.stopAnimating()
                self.searchProduct = searchBar.text!
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
extension SearchProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        if search?.products?.count == 0 {
            emptyLabel.text = "Ничего не найдено"
            emptyLabel.textColor = .gray
            emptyLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            emptyLabel.textAlignment = NSTextAlignment.center
            collectionView.backgroundView = emptyLabel
            return 0
        }
        else {
            emptyLabel.text = ""
            return search?.products?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicinesCollectionViewCell.identifier, for: indexPath) as! MedicinesCollectionViewCell
        let url = "http://374315-ca17278.tmweb.ru/upload_product/"
        let completeURL = url + (search?.products?[indexPath.row].product_pic ?? "")
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: completeURL))
        cell.title.text = search?.products?[indexPath.row].product_name ?? ""
        cell.price.text = search?.products?[indexPath.row].product_price ?? ""
        cell.id = search?.products?[indexPath.row].id ?? ""
        cell.is_favorite = ((search?.products?[indexPath.row].is_favorite) != nil)
        cell.prices = search?.products?[indexPath.row].product_price ?? ""
        cell.titleMedicine = search?.products?[indexPath.row].product_name ?? ""
        cell.images = search?.products?[indexPath.row].product_pic ?? ""
        cell.count = Int(search?.products?[indexPath.row].total_count_in_store ?? "") ?? 0
        cell.button.setImage(UIImage(named: "favorite"), for: .normal)
        cell.configureConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchCollectionReusableView.identifier, for: indexPath) as! SearchCollectionReusableView
        header.filterbutton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        header.configure()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.3, height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AboutProductViewController()
        vc.title = search?.products?[indexPath.row].product_name ?? ""
        vc.id = search?.products?[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
