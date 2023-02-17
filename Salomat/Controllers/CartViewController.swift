//
//  BasketViewController.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import CoreData

class CartViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var basketCollectionView = CartCollectionView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var network = NetworkService()
    var data = [Basket]()
    var commitPredicate: NSPredicate?
    
    lazy var promocode: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Активировать промо код"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor(red: 0.929, green: 0.929, blue: 1, alpha: 1).cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var promocodeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        button.setImage(UIImage(named: "inactive.icon"), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        button.setTitle("Оформить заказ", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Корзина"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.282, green: 0.224, blue: 0.765, alpha: 1)
        hideKeyboardWhenTappedAround()
        basketCollectionView.delegate = self
        basketCollectionView.dataSource = self
        view.setNeedsDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadArticles()
        if data.count == 0 {
            configure()
            button.removeFromSuperview()
        }
        else if data.count != 0{
            configureConstraints()
        }
    }
    
    func configure() {
        view.addSubview(basketCollectionView)
        button.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            basketCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            basketCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            basketCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
    }
    
    func configureConstraints() {
        view.addSubview(basketCollectionView)
        view.addSubview(button)
        button.backgroundColor = UIColor(red: 0.118, green: 0.745, blue: 0.745, alpha: 1)
        
        NSLayoutConstraint.activate([
            
            basketCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            basketCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height),
            basketCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width),

            button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func buttonAction() {
        let vc = InfoAboutDeliveryViewController()
        vc.title = "Информация о доставке"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadArticles() {
        let request: NSFetchRequest <Basket> = Basket.fetchRequest()
        do {
            data = try context.fetch(request)
            basketCollectionView.data = data
            basketCollectionView.reloadData()
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
}
extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        if data.count == 0 {
            image.image = UIImage(named: "cart 1")
            collectionView.backgroundView = image
            return 0
        }
        else {
            image.image = UIImage(named: "")
            collectionView.backgroundView = image
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as! CartCollectionViewCell
        let url = "http://slomat2.colibri.tj/upload_product/"
        let completeURL = url + (data[indexPath.row].image ?? "")
        cell.image.downloaded(from: completeURL)
        cell.titleMedicine = data[indexPath.row].title ?? ""
        cell.title.text = data[indexPath.row].title
        cell.stepper.value = Double(data[indexPath.row].amount ?? "") ?? 0
        cell.prices = data[indexPath.row].price ?? ""
        cell.price.text = String(format: "%.2f", (Double(data[indexPath.row].amount ?? "") ?? 0) * (Double(data[indexPath.row].price ?? "") ?? 0)) + " сом"
        cell.ml.text = "50 мл"
        cell.art.text = "Арт. 10120"
        cell.stepperValue.text = data[indexPath.row].amount ?? ""
        cell.id = data[indexPath.row].id ?? ""
        cell.removeProductButton.layer.setValue(indexPath.row, forKey: "index")
        cell.removeProductButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height / 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
             
         case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CartHeaderCollectionReusableView.identifier, for: indexPath) as! CartHeaderCollectionReusableView
             return header
             
         case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasketFooterCollectionReusableView.identifier, for: indexPath) as! BasketFooterCollectionReusableView
            footer.cost.text = String(format: "%.2f", calculateCartTotalWithoutDelivery()) + " сом"
            footer.delivery.text = "5.00" + " сом"
            footer.totalCost.text = String(format: "%.2f", calculateCartTotalWithDelivery()) + " сом"
            footer.configure()
            return footer
             
         default:
             
             assert(false, "Unexpected element kind")
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if data.count != 0 {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height - 320)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if data.count != 0 {
            return CGSize(width: collectionView.frame.size.width, height: 50)
        }
        return CGSize(width: 0, height: 0)
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
    
    func calculateCartTotalWithoutDelivery() -> Double{
        var total = 0.0
        if self.data.count > 0 {
            for index in 0...self.data.count - 1 {
                total += (Double(data[index].price ?? "") ?? 0) * (Double(data[index].amount!) ?? 0)
            }
        }
        return total
    }
    
    @objc func deleteUser(sender:UIButton) {
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        let objectToDelete = data.remove(at: i)
            basketCollectionView.reloadData()
        self.context.delete(objectToDelete)
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
}

