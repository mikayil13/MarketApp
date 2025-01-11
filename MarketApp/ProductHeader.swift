//
//  ProductHeader.swift
//  MarketApp
//
//  Created by Mikayil on 09.01.25.
//

import UIKit

class ProductHeader: UICollectionReusableView {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    var filteredProducts = [Product]()
    var productList = [Product]()
    let maneger = Maneger()
    var categories = [Category]()
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.register(UINib(nibName: "HeaderCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        maneger.decodeCategoryJSON { categories in
            self.categories = categories
            print(categories)
        }
    }

    
}

extension ProductHeader: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            categories.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.configure(data: categories[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            .init(width: 180 , height: 165)
        }
    
        }
    
    

    
