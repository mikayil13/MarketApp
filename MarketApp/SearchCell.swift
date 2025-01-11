//
//  SearchCell.swift
//  MarketApp
//
//  Created by Mikayil on 11.01.25.
//

import UIKit

class SearchCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configure(category: Category) {
            label.text = category.categoryName
        }
    }
    

