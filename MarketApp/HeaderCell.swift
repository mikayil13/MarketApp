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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        func configure(data: Category) {
            label.text = data.categoryName
            image.image = UIImage(named: data.categoryImage)
        }
    }

