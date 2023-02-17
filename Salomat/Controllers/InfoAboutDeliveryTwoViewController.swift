//
//  InfoAboutDeliveryTwoViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 14/10/22.
//

import UIKit
import CoreData
import KeychainAccess

class InfoAboutDeliveryTwoViewController: UIViewController {
    var price: String = ""
    var name: String = ""
    var address: String = ""
    var total_price: String = ""
    var user_id: String = ""
    var phone_number: String = ""
    var phone_number2: String = ""
    var product_total_count = ""
    var comment: String = ""
    var orders = ["product_id": Int(), "product_count": Int()]
    var orderData: Orders?
    var data = [Basket]()
    var commitPredicate: NSPredicate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var condition: Bool = true
    var deliveryCondition: Bool = false
    var qwert: Any?
    let keychain = Keychain(service: "tj.info.Salomat")
        
    struct OrderProducts {
        var product_id: Int
        var product_count: Int
    }
    
    struct Constants {
        static let backgroundAlphaTo:  CGFloat = 0.6
    }
    private var myTargetView: UIView?
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    lazy var alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.cornerRadius = 12
        alert.layer.masksToBounds = true
        return alert
    }()
    
    lazy var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var uiView2: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var uiView3: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var cancel: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = .white
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(gotoMainScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var book: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(request), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var goodsCollectionView = GoodsCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        allOrders()
        print(data.count)
        if data.count != 0 {
            for i in 1...data.count {
                print(data[i - 1].id ?? "" , "here")
                print(data)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadArticles()
    }
    
    func calculateCartTotalWithDelivery() -> Double{
        var total = 0.0
        if self.data.count > 0 {
            for index in 0...self.data.count - 1 {
                total += (Double(data[index].price ?? "") ?? 0) * (Double(data[index].amount!) ?? 0)
            }
        }
        return total + 5
    }
    
    func allOrders() -> [String: Any] {
        var dict: [String: Any] = ["items": []]

        for index in 0...data.count - 1 {
                var dict1: [String: Any] = [
                    "product_id": data[index].id ?? "",
                    "product_count": data[index].amount ?? ""
                ]
                var existingItems = dict["items"] as? [[String: Any]] ?? [[String: Any]]()

                // append the item
                existingItems.append(dict1)

                // replace back into `data`
                dict["items"] = existingItems

                print(dict, "tom")

        }
        qwert = dict["items"]
        print(dict["items"], "tommy")
        return dict
    }
    
    func delivery20tjs() -> Double {
        var total = 0.0
        if self.data.count > 0 {
            for index in 0...self.data.count - 1 {
                total += (Double(data[index].price ?? "") ?? 0) * (Double(data[index].amount!) ?? 0)
            }
        }
        return total + 20
    }
    @objc func request() {
        
        var dict: [String: Any] =
        ["total_price": total_price, "user_id" : keychain["UserID"] ?? "", "phone_number" :phone_number,"phone_number2": phone_number2, "name" : name,"product_total_count": "1","address" : address, "comment" :comment, "delivery_id": "1", "products": qwert ?? []
        ]

        var  jsonData = NSData()
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) as NSData
            // you can now cast it with the right type
        } catch {
            print(error.localizedDescription)
        }
        
        let url:URL = URL(string: "http://374315-ca17278.tmweb.ru/orders")!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExMiIsImxvZ2luIjoiOTg3MzA1OTU5IiwidGltZSI6MTY2OTU1MzMyN30.TZKePf9Wza_mXTrs3pVK6Pt3P9ftp8ZuaxnXfNYQ2yY", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData as Data
        
        
        let task = session.dataTask(with: request as URLRequest) {
            (
                data, response, error) in
            
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            let dataString =  String(data: data, encoding: String.Encoding.utf8)
            print("no data",dataString ?? "no data")
            
            do {
                let urlData = try JSONDecoder().decode(Orders.self, from: data)
                print(urlData, "yyeeeeh")
                self.orderData = urlData
                let user_id = self.orderData?.order_id ?? 0
                print(self.orderData, "ooommmgg")
            }catch let jsonError {
                print("Failed to decode JSON", jsonError)
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                }
            }
                DispatchQueue.main.async {
                    self.showAlert(with: "Всё готово", message: "Наш специалист свяжется с вами в ближайшее время. Спасибо за покупку", on: self)
                }
           
        }
        task.resume()
    }
    
    // Create custom alert
    func showAlert(with title: String, message: String, on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 120, height: 400)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(titleLabel)
        
        let image = UIImageView()
        image.image = UIImage(named: "done")
        image.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(image)
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor =  UIColor(red: 0.478, green: 0.463, blue: 0.617, alpha: 1)
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(messageLabel)
        
        let orderID = UIButton()
        orderID.setTitle("Номер заказа №\(orderData?.order_id ?? 0)", for: .normal)
        orderID.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        orderID.setTitleColor(.black, for: .normal)
        orderID.layer.cornerRadius = 4
        orderID.layer.masksToBounds = true
        orderID.backgroundColor = .white
        orderID.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        orderID.layer.borderWidth = 1
        orderID.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(orderID)
        
        let button = UIButton()
        button.setTitle("На главную", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(gotoMainScreen), for: .touchUpInside)
        alertView.addSubview(button)
        self.backgroundView.alpha = Constants.backgroundAlphaTo
        self.alertView.center = targetView.center
        
        // Constraints
        image.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 30).isActive = true
        image.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10).isActive = true
        
        orderID.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30).isActive = true
        orderID.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45).isActive = true
        orderID.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -45).isActive = true
        orderID.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        button.topAnchor.constraint(equalTo: orderID.bottomAnchor, constant: 30).isActive = true
        button.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 60).isActive = true
        button.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func gotoMainScreen() {
        let reg = MainTabBarViewController()
        reg.selectedIndex = 4
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = reg
    }
    
    @objc func dismissAlert() {
        self.alertView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
    }
    
    func loadArticles() {
        let request: NSFetchRequest <Basket> = Basket.fetchRequest()
        do {
            data = try context.fetch(request)
            goodsCollectionView.data = data
            total_price = String(format: "%.2f", calculateCartTotalWithDelivery())
            goodsCollectionView.reloadData()
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func configure() {
        view.addSubview(uiView)
        view.addSubview(uiView2)
        view.addSubview(uiView3)
        view.addSubview(goodsCollectionView)
        view.addSubview(cancel)
        view.addSubview(book)
        
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uiView.heightAnchor.constraint(equalToConstant: 3),
            uiView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5),
            
            uiView2.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            uiView2.leadingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: 11),
            uiView2.heightAnchor.constraint(equalToConstant: 3),
            uiView2.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5),
            
            uiView3.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            uiView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            uiView3.heightAnchor.constraint(equalToConstant: 3),
            uiView3.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5),
            
            goodsCollectionView.topAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 40),
            goodsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goodsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goodsCollectionView.bottomAnchor.constraint(equalTo: cancel.topAnchor, constant: -3),
        
            cancel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            cancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancel.heightAnchor.constraint(equalToConstant: 45),
            cancel.widthAnchor.constraint(equalToConstant: 160),
            
            book.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            book.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            book.leadingAnchor.constraint(equalTo: cancel.trailingAnchor, constant: 20),
            book.heightAnchor.constraint(equalToConstant: 45),
            book.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
}
