//
//  MadicinesCollectionViewCell.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import CoreData
import SkeletonView
import Cosmos
import TinyConstraints
import KeychainAccess

class MedicinesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MedicinesCollectionViewCell"
    var count = 0
    var index: IndexPath!
    var indexPath: Int = 0
    var favoritesModel: FavoritesData?
    var condition: Bool = false
    var dataBasket = [Basket]()
    var dataModel = [DataModel]()
    var id: String = ""
    var is_favorite: Bool = false
    var titleMedicine: String = ""
    var images: String = ""
    var prices: String = ""
    var commitPredicate: NSPredicate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var alert: UIAlertController!
    let keychain = Keychain(service: "tj.info.Salomat")
    
    lazy var cosmosView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0.0
        cosmos.settings.starSize = 10
        cosmos.settings.fillMode = .precise
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        return cosmos
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.frame = CGRect(x: 40, y: 40, width: 95, height: 95)
        image.translatesAutoresizingMaskIntoConstraints = true
        return image
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.textColor = UIColor(red: 0.22, green: 0.208, blue: 0.325, alpha: 1)
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 140, y: 20, width: 23, height: 21)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var price: UILabel = {
        let price = UILabel()
        price.textColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        price.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    lazy var cartButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        uiView.layer.borderColor = UIColor(red: 0.738, green: 0.741, blue: 1, alpha: 1).cgColor
        uiView.layer.borderWidth = 1
        uiView.layer.cornerRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    lazy var uiViewTitle: UILabel = {
        let title = UILabel()
        title.text = "Авторизуйтесь"
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func configureConstraints() {
        
        if count <= 0 {
            cartButton.backgroundColor = .white
            cartButton.setTitle("Нет в наличии", for: .normal)
            cartButton.setTitleColor(UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1), for: .normal)
            
        }
        else if count > 0 {
            cartButton.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
            cartButton.setTitle("В корзину", for: .normal)
            cartButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            cartButton.addTarget(self, action: #selector(saveInBasket), for: .touchUpInside)
        }
        
        contentView.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(cosmosView)
        contentView.addSubview(button)
        contentView.addSubview(price)
        contentView.addSubview(cartButton)
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cosmosView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            cosmosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            price.bottomAnchor.constraint(equalTo: cartButton.topAnchor, constant: -15),
            price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            cartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cartButton.heightAnchor.constraint(equalToConstant: 28),
            cartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func saveMedicine() {
        let data = DataModel(context: self.context)
        data.id = id
        data.is_favorite = true
        data.title = titleMedicine
        data.price = prices
        data.image = images
        self.dataModel.append(data)
        print("ischecked")
       do {
           try context.save()
       }catch {
           print("Error saving context \(error)")
       }
    }

    func deleteMedicine() {
        let object: NSFetchRequest <DataModel> = DataModel.fetchRequest()
        object.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "id == %@", id)
        do {
            let object = try context.fetch(object)
            for i in object {
                if i.id == id {
                    context.delete(i)
                }
                do {
                    try context.save()
                }catch {
                    print("Error1 \(error)")
                }
            }
        }
        catch {
            print("Error2 \(error)")
        }
    }
    
    func removeFromCart() {
        let object: NSFetchRequest <DataModel> = DataModel.fetchRequest()
        object.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "id == %@", id)
        do {
            let object = try context.fetch(object)
            for i in object {
                context.delete(i)
            }
            do {
                try context.save()
            }
            catch {
                print("Error \(error)")
            }
        }
        catch {
            print("Error \(error)")
        }
    }

    @objc func buttonAction() {
        if keychain["UserID"] ?? "" == "" {
            showAlert()
        } else {
            let fetchRequest: NSFetchRequest <DataModel> = DataModel.fetchRequest()
            commitPredicate = NSPredicate(format: "id == %@", id)
            fetchRequest.predicate = commitPredicate
            do{
                let data = try context.fetch(fetchRequest).first
                if  data?.id != id {
                    print("\(data?.id) and \(id)")
                    button.setImage(UIImage(named: "favorite 1"), for: .normal)
                    addFavorites()
                    saveMedicine()
                }
                else if data?.id == id{
                    button.setImage(UIImage(named: "favorite"), for: .normal)
                    deleteFavorites()
                    deleteMedicine()
                }
            }
            catch {
                print("Error1\(error)")
            }
        }
    }
    
    func saveMedicineInBasket() {
        let data = Basket(context: self.context)
        data.id = id
        data.title = titleMedicine
        data.price = prices
        data.image = images
        data.amount = "1"
        self.dataBasket.append(data)
       do {
           try context.save()
       }catch {
           print("Error saving context \(error)")
       }
    }

    func deleteMedicineInBasket() {
        let object: NSFetchRequest <Basket> = Basket.fetchRequest()
        commitPredicate = NSPredicate(format: "id == %@", id)
        object.predicate = commitPredicate
        do {
            let object = try context.fetch(object)
            for i in object {
                if i.id == id {
                    context.delete(i)
                }
                do {
                    try context.save()
                }catch {
                    print("Error1 \(error)")
                }
            }
        }
        catch {
            print("Error2 \(error)")
        }
    }
    
    func showAlert() {
        contentView.addSubview(uiView)
        uiView.addSubview(uiViewTitle)
        
        NSLayoutConstraint.activate([
            uiView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            uiView.heightAnchor.constraint(equalToConstant: 30),
            uiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            uiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            uiViewTitle.centerXAnchor.constraint(equalTo: uiView.centerXAnchor),
            uiViewTitle.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
        ])
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(hideAlert), userInfo: nil, repeats: false)
    }
    
    @objc func hideAlert() {
        self.uiView.removeFromSuperview()
    }
    
    @objc func saveInBasket() {
        if keychain["UserID"] ?? "" == "" {
            showAlert()
        }
        else {
            let fetchRequest: NSFetchRequest <Basket> = Basket.fetchRequest()
            commitPredicate = NSPredicate(format: "title == %@", titleMedicine)
            fetchRequest.predicate = commitPredicate
            do{
                let data = try context.fetch(fetchRequest).first
                if data == nil && data?.title != titleMedicine {
                    cartButton.backgroundColor = UIColor(red: 0.937, green: 0.365, blue: 0.439, alpha: 1)
                    cartButton.setTitle("Убрать из корзины", for: .normal)
                    contentView.layer.borderColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1).cgColor
                    saveMedicineInBasket()
                }
                else if data?.title == titleMedicine {
                    cartButton.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
                    contentView.layer.borderColor = UIColor(red: 0.929, green: 0.93, blue: 1, alpha: 1).cgColor
                    cartButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                    cartButton.setTitle("В корзину", for: .normal)
                    deleteMedicineInBasket()
                }
            }
            catch {
                print("Error1\(error)")
            }
        }
    }
    
    func addFavorites() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/favorites") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "user_id": keychain["UserID"] ?? "",
            "product_id": id
        ]
            request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
                    
            else {
                //check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            }
            catch {
                print(error)
            }
         
        
            guard (200 ... 299) ~= response.statusCode else {
                //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
        }
        task.resume()
    }
    
    func deleteFavorites() {
        guard let url = URL(string: "http://374315-ca17278.tmweb.ru/favorites/delete") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "user_id": keychain["UserID"] ?? "",
            "product_id": id
        ]
            request.httpBody = parameters.percentEncoded()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
                    
            else {
                //check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            }
            catch {
                print(error)
            }
        
            guard (200 ... 299) ~= response.statusCode else {
                //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
        }
        task.resume()
    }
}
