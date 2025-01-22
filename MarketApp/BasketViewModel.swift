//
//  BasketViewModel.swift
//  MarketApp
//
//  Created by Mikayil on 13.01.25.
//

import Foundation
import UIKit
class BasketViewModel {
    var basketProducts: [Product] = []
    private let adapter = FileAdapter()
    func addProductToBasket(product: Product) {
        if let index = basketProducts.firstIndex(where: { $0.categoryId == product.categoryId }) {
            basketProducts[index].count += product.count
        } else {
            basketProducts.append(product)
        }
        writeData()
    }
    func readData(totalPrice: UILabel) {
        adapter.readData { items in
            self.basketProducts = items ?? []
            let formattedPrice = self.updateTotalPrice()
            totalPrice.text = "$\(formattedPrice)"
        }
    }
    func writeData() {
        adapter.writeData(items: basketProducts)
    }
    func updateTotalPrice() -> String {
        let total = basketProducts.reduce(0) { $0 + (($1.price ?? 0) * Double($1.quantity ?? 1)) }
        let formattedPrice = String(format: "%.2f", total)
        return formattedPrice
    }
    func getOrder(totalPrice: UILabel, tableView: UITableView) {
        basketProducts.removeAll()
        writeData()
        let formattedPrice = updateTotalPrice()
        totalPrice.text = "$\(formattedPrice)"
        tableView.reloadData()
    }
}
