//
//  BasketController.swift
//  MarketApp
//
//  Created by Mikayil on 12.01.25.
//

import UIKit

class BasketController: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    weak var delegate: BasketCellDelegate?
    let basketViewModel = BasketViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getup()
    }
    @IBAction func Confirm(_ sender: Any) {
    }
    
    func getup() {
        title = "Basket"
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "BasketCell", bundle: nil), forCellReuseIdentifier: "BasketCell")
        basketViewModel.readData(totalPrice: totalPrice)
    }
    
}
extension BasketController: UITableViewDataSource, UITableViewDelegate,BasketCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketViewModel.basketProducts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as! BasketCell
        cell.configure(data: basketViewModel.basketProducts[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func didUpdateQuantity(product: Product, newQuantity quantity: Int) {
        if let index = basketViewModel.basketProducts.firstIndex(where: { $0.categoryId == product.categoryId }) {
                if quantity == 0 {
                    basketViewModel.basketProducts.remove(at: index)
                    basketViewModel.writeData()
                    table.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                } else {
                    basketViewModel.basketProducts[index].quantity = quantity
                    basketViewModel.writeData()
                }
                let formattedPrice = basketViewModel.updateTotalPrice()
                totalPrice.text = formattedPrice
            }
            
        }
    }

