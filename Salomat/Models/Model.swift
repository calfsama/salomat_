//
//  Model.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import Foundation
import UIKit

struct Categories {
    let image: UIImage
    let title: String
    
    static func items()-> [Categories] {
        let first = Categories(image: UIImage(named: "icon")!, title: "При аллергии")
        let second = Categories(image: UIImage(named: "vitamin")!, title: "Витамины")
        let third = Categories(image: UIImage(named: "sales")!, title: "Акции")
        
        return [first, second, third]
    }
}

struct Info {
    let image: UIImage
    
    static func items() -> [Info] {
        let first = Info(image: UIImage(named: "about-us")!)
        let second = Info(image: UIImage(named: "about-us-1")!)
        let third = Info(image: UIImage(named: "about-us-2")!)
        
        return [first, second, third]
    }
}

struct Settings {
    let image: String
    let title: String
    
    static func items() -> [Settings] {
        let empty = Settings(image: "", title: "")
        let first = Settings(image: "Profile mob", title: "Личная информация")
        let second = Settings(image: "notification", title: "Уведомления и новости")
        let third = Settings(image: "cart", title: "Мои заказы")
        let fourth = Settings(image: "phone", title: "Номер телефона")
        let fifth = Settings(image: "security", title: "Безопасность")
        let sixth = Settings(image: "log out", title: "Выход")
        
        return [empty, first, second, third, fourth, fifth, sixth]
    }
}

struct Messenger {
    let image: UIImage
    
    static func items() -> [Messenger] {
        let first = Messenger(image: UIImage(named: "viber")!)
        let second = Messenger(image: UIImage(named: "telegram 1")!)
        let third = Messenger(image: UIImage(named: "imo")!)
        
        return [first, second, third]
    }
}

