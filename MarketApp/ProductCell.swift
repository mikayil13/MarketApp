//
//  ProductCell.swift
//  MarketApp
//
//  Created by Mikayil on 09.01.25.
//

import UIKit
protocol ProductCellDelegate: AnyObject {
    func didAddToBasket(product: Product)
}

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    var delegate: ProductCellDelegate?
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
    }
    
    
    func configure(data: Product) {
        self.product = data
        name.text = data.productName
        image.image = UIImage(named: data.productImage!)
        price.text = "$\(data.price!)"
    }
    
    @IBAction func addbutton(_ sender: Any) {
        guard let product = product else { return }
           delegate?.didAddToBasket(product: product)
 }
}


