//
//  MainViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import SkeletonView

class MainViewController: UIViewController {
    var text: String = ""
    var url: String = ""
    var timer = Timer()
    var banners: MainSliders?
    var counter = 0
    var initialScrollDone: Bool = true
    
    lazy var uiscrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2350)
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var categoryCollectionView: CategoryCollectionView!
    var bannersCollectionView = BannerCollectionView()
    var itemsCollectionView: ItemsCollectionView!
    var bannerMedicineCollectionView = BannerMedicineCollectionView()
    var medicinalProductsCollectionView: MedicinalProductsCollectionView!
    var blogCollectionView: BlogCollectionView!
    var vitaminCollectionView = VitaminCollectionView()
    var badsCollectionView: BADCollectionView!
    var network = NetworkService()
    var product: ProdsOfTheDay?
    
    lazy var header: UIView = {
        let header = UIView()
        header.backgroundColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var header2: UIView = {
        let header = UIView()
        header.backgroundColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var header3: UIView = {
        let header = UIView()
        header.backgroundColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var header4: UIView = {
        let header = UIView()
        header.backgroundColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var label: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.text = "Товары дня"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var label2: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.text = "Лекарственные средства"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var label3: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.text = "Блог"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var label4: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        title.text = "Все статьи"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var header5: UIView = {
        let header = UIView()
        header.backgroundColor = .white
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var label5: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.text = "Витамины и БАД"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var allArticles: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitle("Все статьи>", for: .normal)
        button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var link: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Group"), for: .normal)
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var instagram: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Instagram"), for: .normal)
        button.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var facebook: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebook"), for: .normal)
        button.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var telegram: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "telegram"), for: .normal)
        button.addTarget(self, action: #selector(openTelegram), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var filter: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter Horizontal"), for: .normal)
        button.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var filterForVitamin: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter Horizontal"), for: .normal)
        button.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        categoryCollectionView = CategoryCollectionView(nav: self.navigationController!)
        blogCollectionView = BlogCollectionView(nav: self.navigationController!)
        itemsCollectionView = ItemsCollectionView(nav: self.navigationController!)
        medicinalProductsCollectionView = MedicinalProductsCollectionView(nav: self.navigationController!)
        badsCollectionView = BADCollectionView(nav: self.navigationController!)
        categoryCollectionView.set(cells: Categories.items())
        configureConstraints()
        fetchFromApi()
        fetchData()
        fetchBlogData()
        fetchVitemin()
        fetchBanner()
        let logo = UIImage(named: "logo 2")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(showCategories))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: self, action: #selector(btnCollection))
    }
    
    @objc func btnAction() {
        let vc = BlogListViewController()
        vc.title = "Блог"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnCollection() {
        let v = SearchProductViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews()
        
        if !self.initialScrollDone {
            
            self.initialScrollDone = true
            let index = IndexPath.init(item: counter, section: 0)
            self.bannersCollectionView.scrollToItem(at:index, at: .centeredHorizontally, animated: true)
            counter += 1
        }

    }
    
    func configureConstraints() {
        view.addSubview(uiscrollView)
        uiscrollView.addSubview(categoryCollectionView)
        uiscrollView.addSubview(bannersCollectionView)
        uiscrollView.addSubview(itemsCollectionView)
        uiscrollView.addSubview(bannerMedicineCollectionView)
        uiscrollView.addSubview(header)
        uiscrollView.addSubview(label)
        uiscrollView.addSubview(header2)
        uiscrollView.addSubview(label2)
        uiscrollView.addSubview(medicinalProductsCollectionView)
        uiscrollView.addSubview(header3)
        uiscrollView.addSubview(label3)
        uiscrollView.addSubview(blogCollectionView)
        uiscrollView.addSubview(header4)
        uiscrollView.addSubview(button)
        uiscrollView.addSubview(label4)
        uiscrollView.addSubview(header5)
        uiscrollView.addSubview(label5)
        uiscrollView.addSubview(vitaminCollectionView)
        uiscrollView.addSubview(badsCollectionView)
        uiscrollView.addSubview(allArticles)
        uiscrollView.addSubview(link)
        uiscrollView.addSubview(instagram)
        uiscrollView.addSubview(facebook)
        uiscrollView.addSubview(telegram)
        uiscrollView.addSubview(filter)
        uiscrollView.addSubview(filterForVitamin)
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: uiscrollView.topAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 120),
            categoryCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            
            bannersCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 16),
            bannersCollectionView.heightAnchor.constraint(equalToConstant: 200),
            bannersCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            
            header.heightAnchor.constraint(equalToConstant: 30),
            header.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            header.topAnchor.constraint(equalTo: bannersCollectionView.bottomAnchor, constant: 25),
            
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: header.topAnchor),
            
            itemsCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            itemsCollectionView.heightAnchor.constraint(equalToConstant: 300),
            itemsCollectionView.topAnchor.constraint(equalTo: header.bottomAnchor),
            
            header2.topAnchor.constraint(equalTo: itemsCollectionView.bottomAnchor, constant: 20),
            header2.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            header2.heightAnchor.constraint(equalToConstant: 30),
            
            label2.topAnchor.constraint(equalTo: header2.topAnchor),
            label2.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor, constant: 16),
            
            filter.centerYAnchor.constraint(equalTo: label2.centerYAnchor),
            filter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bannerMedicineCollectionView.topAnchor.constraint(equalTo: header2.bottomAnchor),
            bannerMedicineCollectionView.widthAnchor.constraint(equalTo: uiscrollView.widthAnchor),
            bannerMedicineCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            medicinalProductsCollectionView.topAnchor.constraint(equalTo: bannerMedicineCollectionView.bottomAnchor, constant: 10),
            medicinalProductsCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            medicinalProductsCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            header3.topAnchor.constraint(equalTo: medicinalProductsCollectionView.bottomAnchor, constant: 20),
            header3.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            header3.heightAnchor.constraint(equalToConstant: 30),
            
            label3.centerYAnchor.constraint(equalTo: header3.centerYAnchor),
            label3.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor, constant: 16),
            
            allArticles.topAnchor.constraint(equalTo: header3.topAnchor),
            allArticles.bottomAnchor.constraint(equalTo: header3.bottomAnchor),
            allArticles.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allArticles.widthAnchor.constraint(equalToConstant: 100),
            
            blogCollectionView.topAnchor.constraint(equalTo: header3.bottomAnchor, constant: 20),
            blogCollectionView.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor),
            blogCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            blogCollectionView.heightAnchor.constraint(equalToConstant: 400),
            
            header4.topAnchor.constraint(equalTo: blogCollectionView.bottomAnchor, constant: 16),
            header4.heightAnchor.constraint(equalToConstant: 30),

            button.topAnchor.constraint(equalTo: header4.topAnchor),
            button.bottomAnchor.constraint(equalTo: header4.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 120),
            
            link.topAnchor.constraint(equalTo: header4.topAnchor),
            link.bottomAnchor.constraint(equalTo: header4.bottomAnchor),
            link.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            instagram.topAnchor.constraint(equalTo: header4.topAnchor),
            instagram.bottomAnchor.constraint(equalTo: header4.bottomAnchor),
            instagram.trailingAnchor.constraint(equalTo: link.leadingAnchor, constant: -8),
            
            facebook.topAnchor.constraint(equalTo: header4.topAnchor),
            facebook.bottomAnchor.constraint(equalTo: header4.bottomAnchor),
            facebook.trailingAnchor.constraint(equalTo: instagram.leadingAnchor, constant: -8),
            
            telegram.topAnchor.constraint(equalTo: header4.topAnchor),
            telegram.bottomAnchor.constraint(equalTo: header4.bottomAnchor),
            telegram.trailingAnchor.constraint(equalTo: facebook.leadingAnchor, constant: -8),

            label4.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label4.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            header5.topAnchor.constraint(equalTo: header4.bottomAnchor, constant: 35),
            header5.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            header5.heightAnchor.constraint(equalToConstant: 30),
            
            label5.topAnchor.constraint(equalTo: header5.topAnchor),
            label5.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor, constant: 16),
            
            filterForVitamin.centerYAnchor.constraint(equalTo: label5.centerYAnchor),
            filterForVitamin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            vitaminCollectionView.topAnchor.constraint(equalTo: header5.bottomAnchor),
            vitaminCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            vitaminCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            badsCollectionView.topAnchor.constraint(equalTo: vitaminCollectionView.bottomAnchor),
            badsCollectionView.widthAnchor.constraint(equalToConstant: uiscrollView.frame.size.width),
            badsCollectionView.heightAnchor.constraint(equalToConstant: 285)
        ])
    }
    
    @objc func openTelegram() {
        let telegram = "https://t.me/salomattj"
        let telegramURL = URL(string: telegram)!
        if UIApplication.shared.canOpenURL(telegramURL) {
            UIApplication.shared.open(telegramURL)
        }
        else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/telegram-messenger/id686449807")!)
        }
    }
    
    @objc func openFacebook() {
        let facebook = "https://facebook.com/salomat.tj"
        let facebookURL = URL(string: facebook)!
        if UIApplication.shared.canOpenURL(facebookURL) {
            UIApplication.shared.open(facebookURL)
        }
        else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/ru/app/facebook/id284882215")!)
        }
    }
    
    @objc func openInstagram() {
        let instagram = "http://instagram.com/salomat.tj"
        let instagramURL = URL(string: instagram)!
        if UIApplication.shared.canOpenURL(instagramURL) {
            UIApplication.shared.open(instagramURL)
        }
        else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/instagram/id389801252")!)
            print("dnfkjsn")
        }
    }
    
    @objc func openLink() {
        let link = "http://374315-ca17278.tmweb.ru"
        let linkURL = URL(string: link)!
        if UIApplication.shared.canOpenURL(linkURL) {
            UIApplication.shared.open(linkURL)
        }
        else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/instagram/id389801252")!)
            print("dnfkjsn")
        }
    }
    
    @objc func showCategories() {
        let vc =  CatForMainPageViewController()
        vc.title = "Каталог товаров"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {

            if let presentationController = navigationController.presentationController as? UISheetPresentationController {

                presentationController.detents =  [.medium(), .large()]
                self.present(navigationController, animated: true)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func searchContr() {
        let vc = SearchProductViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchFromApi(){
        let urlString = "/products/prods_of_the_day?"
        self.network.fetchData(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.itemsCollectionView.isSkeletonable = true
                self.itemsCollectionView.startSkeletonAnimation()
                self.itemsCollectionView.product = response
                self.itemsCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchData(){
        let urlString = "/products/categories_for_main_page?"
        self.network.fetchFromApi(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.medicinalProductsCollectionView.categories = response
                self.bannerMedicineCollectionView.banner = response
                self.vitaminCollectionView.banner = response
                self.medicinalProductsCollectionView.reloadData()
                self.bannerMedicineCollectionView.reloadData()
                self.vitaminCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchBlogData(){
        let urlString = "/blogs/blog_popular?page=1"
        self.network.fetchBlogsData(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.blogCollectionView.blogs = response
                self.blogCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchVitemin(){
        let urlString = "/products/categories_for_main_page?id=8"
        self.network.fetchFromApi(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.badsCollectionView.vitamin = response
                self.badsCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchBanner(){
        let urlString = "/products/main_sliders"
        self.network.fetchBanners(urlString: urlString) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.bannersCollectionView.banners = response
                self.banners = response
                self.bannersCollectionView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    @objc func action() {
        let vc = CategoriesViewController()
        if #available(iOS 15.0, *) {
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.large(), .medium()]
            }
        } else {
            // Fallback on earlier versions
        }
        present(vc, animated: true, completion: nil)
    }
}

