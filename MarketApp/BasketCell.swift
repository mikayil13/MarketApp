//
//  BasketCell.swift
//  MarketApp
//
//  Created by Mikayil on 12.01.25.
//

import UIKit
protocol BasketCellDelegate: AnyObject {
    func didUpdateQuantity(product: Product, newQuantity: Int)
}


class BasketCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var count: UILabel!
    
        var product: Product?
        weak var delegate: BasketCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.addTarget(self, action: #selector(updateValue), for: .valueChanged)
          stepper.minimumValue = 0
          stepper.maximumValue = 99
      }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
      
    }
      
      func configure(data: Product) {
          product = data
          productName.text = data.productName
          productPrice.text = "$\(data.price!)"
          productImage.image = UIImage(named: data.productImage!)
          stepper.value = Double(data.count)
          count.text = "\(data.count)"
      }
    @objc func updateValue(_ sender: UIStepper) {
        guard let product = product else { return }
        let newQuantity = Int(sender.value)
        count.text = "\(newQuantity)"
        productPrice.text = String(format: "$%.2f", (product.price!) * Double(newQuantity))
        delegate?.didUpdateQuantity(product: product, newQuantity: newQuantity)
           }
    
       }
  
        

