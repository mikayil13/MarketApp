//
//  SearchHeaderCollection.swift
//  MarketApp
//
//  Created by Mikayil on 11.01.25.
//

import UIKit
protocol SearchHeaderCollectionDelegate: AnyObject {
    func didSelectCategory(_ category: Category)
}


class SearchHeaderCollection: UICollectionReusableView {
    weak var delegate: SearchHeaderCollectionDelegate?
    @IBOutlet weak var collection: UICollectionView!
    var categories = [Category]()
    let maneger = Maneger()
    var selectedCategory: Category?
    var selectedIndexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        getup()
    }
    
    func getup() {
        collection.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 22
           layout.minimumLineSpacing = 22
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = true
        collection.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        maneger.decodeCategoryJSON { categories in
            self.categories = categories
            self.collection.reloadData()
        }
    }
}
extension SearchHeaderCollection: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            categories.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
            let category = categories[indexPath.row]
                 cell.configure(category: category)
                 if indexPath == selectedIndexPath {
                     cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                 } else {
                     cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                 }
                 
                 return cell
             }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedCategory = categories[indexPath.row]
            self.selectedCategory = selectedCategory
            self.selectedIndexPath = indexPath
            delegate?.didSelectCategory(selectedCategory)
            collectionView.reloadData()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            .init(width: 100 , height: 45)
        }
    
}
