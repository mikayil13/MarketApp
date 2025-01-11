//
//  Model.swift
//  MarketApp
//
//  Created by Mikayil on 10.01.25.
//

import Foundation

struct Category: Codable {
    let id: Int
    let categoryName: String
    let categoryImage: String
}

struct Product: Codable {
    let categoryId: Int
    let productName: String
    let productImage: String
    let price: Double
    let count: Int
}
