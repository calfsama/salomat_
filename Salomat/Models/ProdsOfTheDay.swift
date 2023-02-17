//
//  ProdsOfTheDay.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 28/09/22.
//

import Foundation

struct ProdsOfTheDay: Codable {
    var prods_of_the_day: [Products]?
}

struct Products: Codable {
    var id: String?
    var product_name: String?
    var product_about: String?
    var product_type: String?
    var product_form: String?
    var product_brand: Brand?
//    var product_country: String?
//    var product_old_price: String?
    var product_price: String?
    var product_pic: String?
    var total_count_in_store: String?
//    var product_articule: String?
//    var product_of_the_day: String?
//    var product_suggestions: String?
//    var product_in_category: String?
//    var product_status: String?
//    let prod_rating_average: String?
//    var review_count: String?
    var is_favorite: Bool?
//    var base_url: String?
    
    enum CodingKeys: String, CodingKey {
        case id, product_name, product_about
        case product_type, product_form, product_brand
        case product_pic, product_price, is_favorite, total_count_in_store

    }
}

struct Brand: Codable {
    var id: String?
    let brand_name: String?
}



