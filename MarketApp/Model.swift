//
//  Model.swift
//  MarketApp
//
//  Created by Mikayil on 10.01.25.
//

import Foundation

struct Category: Codable,Equatable {
    var id: Int?
    var categoryName: String?
    var categoryImage: String?
}

struct Product: Codable {
    var categoryId: Int?
    var productName: String?
    var productImage: String?
    var price: Double?
    var count: Int
    var quantity: Int?
}
