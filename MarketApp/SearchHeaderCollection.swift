//
//  SearchHeaderCollection.swift
//  MarketApp
//
//  Created by Mikayil on 11.01.25.
//

import UIKit

class SearchHeaderCollection: UICollectionReusableView {
    @IBOutlet weak var collection: UICollectionView!
    var categories = [Category]()
    let maneger = Maneger()
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collection.collectionViewLayout = layout
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
            cell.configure(category: categories[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            .init(width: 120 , height: 40)
        }
    
        }
