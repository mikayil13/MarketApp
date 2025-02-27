

import UIKit

class HomeController: UIViewController, UIScrollViewDelegate,ProductHeaderDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collection: UICollectionView!
    var categories = [Category]()
    let manager = FileAdapter()
    let maneger = Maneger()
    var productList = [Product]()
    var basketItems = [Product]()
    var filteredProducts = [Product]()
    var selectedProduct: Product?
    var selectedCategory: Category?
    var images: [String] = ["1","2","3"]
    var frame = CGRect()
    var timer: Timer?
    var currentPage = 0
    var selectedIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        confugureUI()
        startTimer()
        maneger.decodeProductJSON { products in
            self.productList = products
            self.filteredProducts = products
            self.collection.reloadData()
        }
        maneger.decodeCategoryJSON { categories in
            self.categories = categories
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    func confugureUI() {
        title = "Home"
        collection.delegate = self
        collection.dataSource = self
        collection.collectionViewLayout = UICollectionViewFlowLayout()
        collection.register(UINib(nibName: "ProductHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductHeader")
        collection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        pageControl.numberOfPages = images.count
        for index in 0 ..< images.count {
            frame.origin.x = scrollView.frame.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            scrollView.addSubview(imageView)
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        scrollView.delegate = self
    }
    func filterProductsByCategory() {
        guard let category = selectedCategory else {
            filteredProducts = productList
            collection.reloadData()
            return
        }
        filteredProducts = productList.filter { $0.categoryId == category.id }
        collection.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func autoScroll() {
        currentPage += 1
        if currentPage == images.count {
            currentPage = 0
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageNumber = scrollView.contentOffset.x / scrollView.frame.width
            pageControl.currentPage = Int(pageNumber)
            currentPage = pageControl.currentPage
        }
        let offset = CGPoint(x: scrollView.frame.width * CGFloat(currentPage), y: 0)
        scrollView.setContentOffset(offset, animated: true)
        pageControl.currentPage = currentPage
    }
    func didSelectCategory(_ category: Category) {
        filteredProducts = productList.filter { $0.categoryId == category.id }
        collection.reloadData()
    }
    func addToBasket(index: Int) {
        guard index >= 0 && index < productList.count else {
            return
        }
        let selectedProduct = productList[index]
        manager.readData { basketItems in
            self.basketItems = basketItems ?? []
            self.basketItems.append(selectedProduct)
            self.manager.writeData(items: self.basketItems)
        }
    }
}
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ProductCellDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return filteredProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.delegate = self
        cell.configure(data: filteredProducts[indexPath.row])
        if indexPath == selectedIndexPath {
            cell.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
        } else {
            cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 2
        let totalPadding = padding * 10
        let individualWidth = (collectionView.frame.width - totalPadding) / 2
        return CGSize(width: individualWidth, height: individualWidth + 150)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductHeader", for: indexPath) as! ProductHeader
        header.delegate = self
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.65, height: 320)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
    func didAddToBasket(product: Product) {
        if let index = productList.firstIndex(where: { $0.productName == product.productName }) {
            addToBasket(index: index)
        } else {
            print("Xəta: Məhsul tapılmadı: \(product.productName!)")
        }
    }
}

