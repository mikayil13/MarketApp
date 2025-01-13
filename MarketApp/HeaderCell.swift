//
//  HeaderCell.swift
//  MarketApp
//
//  Created by Mikayil on 09.01.25.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    var isSelectedCategory: Bool = false {
            didSet {
                containerView.backgroundColor = isSelectedCategory ? .black : .clear
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
               self.layer.masksToBounds = true
    }
 
        func configure(data: Category) {
            label.text = data.categoryName
            image.image = UIImage(named: data.categoryImage!)
            
        }
    }

