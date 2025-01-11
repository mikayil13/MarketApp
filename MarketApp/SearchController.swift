//
//  SearchController.swift
//  MarketApp
//
//  Created by Mikayil on 07.01.25.
//

import UIKit

class SearchController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    let maneger = Maneger()
    var productList = [Product]()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        collection.delegate = self
        collection.dataSource = self
        collection.collectionViewLayout = UICollectionViewFlowLayout()
        collection.register(UINib(nibName: "SearchHeaderCollection", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderCollection")
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        maneger.decodeProductJSON { products in
            self.productList = products
            
        }
    }
}
extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.configure(data: productList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let itemsPerRow: CGFloat = 2
        let totalPadding = padding * (itemsPerRow + 1)
        let individualWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
        let heightMultiplier: CGFloat = 1.5
        return CGSize(width: individualWidth, height: individualWidth * heightMultiplier)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchHeaderCollection", for: indexPath) as! SearchHeaderCollection
           return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 150, height: 30)
    }
}


