//
//  Maneger.swift
//  MarketApp
//
//  Created by Mikayil on 10.01.25.
//

import Foundation
class Maneger {
    var products = [Product]()
    var categories = [Category]()
    
    func decodeCategoryJSON(completion: (([Category]) -> Void)) {
        if let fileUrl = Bundle.main.url(forResource: "Category", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                categories = try JSONDecoder().decode([Category].self, from: data)
                completion(categories)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func decodeProductJSON(completion: (([Product]) -> Void)) {
        if let fileUrl = Bundle.main.url(forResource: "Product", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                products = try JSONDecoder().decode([Product].self, from: data)
                completion(products)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
