//
//  ProductCell.swift
//  MarketApp
//
//  Created by Mikayil on 09.01.25.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var containerView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
    }
    
    func configure(data: Product) {
            name.text = data.productName
            image.image = UIImage(named: data.productImage)
            price.text = "$\(data.price)"
        }
}
