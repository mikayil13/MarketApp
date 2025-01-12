//
//  ProductHeader.swift
//  MarketApp
//
//  Created by Mikayil on 09.01.25.
//

import UIKit
protocol ProductHeaderDelegate: AnyObject {
    func didSelectCategory(_ category: Category)
}
class ProductHeader: UICollectionReusableView {
    weak var delegate: ProductHeaderDelegate?
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    var filteredProducts = [Product]()
    var productList = [Product]()
    let maneger = Maneger()
    var selectedCategory: Category?
    var categories = [Category]()
    var selectedIndexPath: IndexPath?
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
    func updateCategories(categories: [Category]) {
        self.categories = categories
        self.collection.reloadData()
       
               }
           }
       


extension ProductHeader: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
        let category = categories[indexPath.row]
        cell.configure(data: category)
        if category == selectedCategory {
            cell.isSelectedCategory = true
        } else {
            cell.isSelectedCategory = false
        }
        if indexPath == selectedIndexPath {
            cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) // Hüceyrəni böyüt
        } else {
            cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) // Hüceyrəni normal ölçüdə saxla
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        delegate?.didSelectCategory(selectedCategory)
        self.selectedCategory = selectedCategory  // Seçimi qeyd et// UI-ni yenilə
        selectedIndexPath = indexPath // Seçilmiş hüceyrənin indexini saxlayırıq
        collectionView.reloadData() //
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 180 , height: 165)
    }
    
}

    
