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
        let padding: CGFloat = 2
        let totalPadding = padding * 10
        let individualWidth = (collectionView.frame.width - totalPadding) / 2
        return CGSize(width: individualWidth, height: individualWidth + 50)
    }
}
