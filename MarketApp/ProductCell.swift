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
    @IBOutlet weak var add: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    weak var delegate: ProductCellDelegate?
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        add.isUserInteractionEnabled = true
        add.isHidden = false
        add.alpha = 1.0
        
    }

    
    func configure(data: Product) {
        self.product = data
        name.text = data.productName
        image.image = UIImage(named: data.productImage!)
        price.text = "$\(data.price!)"
    }
    
    
    
    @IBAction func addButton(_ sender: Any) {
        guard let product = product else { return }
        delegate?.didAddToBasket(product: product)
        if let addButton = sender as? UIButton {
            UIView.animate(withDuration: 0.1) {
                addButton.setTitle("Added", for: .normal)
                addButton.backgroundColor = .gray
                addButton.isEnabled = false
            }
        }
    }
}

