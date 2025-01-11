

import UIKit

class HomeController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collection: UICollectionView!
    
    let maneger = Maneger()
    var productList = [Product]()
    var images: [String] = ["1","2","3"]
    var frame = CGRect()
    var timer: Timer?
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugureUI()
        startTimer()
              maneger.decodeProductJSON { products in
                  self.productList = products
                  
              }
          }
      
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    func confugureUI() {
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

}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
                   return productList.count
            }
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
                cell.configure(data: productList[indexPath.row])
                return cell
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let padding: CGFloat = 3
                let totalPadding = padding * 5
                let individualWidth = (collectionView.frame.width - totalPadding) / 2
                return CGSize(width: individualWidth, height: individualWidth + 80)
            }
            func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductHeader", for: indexPath) as! ProductHeader
                return header
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                return CGSize(width: collectionView.frame.width * 0.65, height: 320)
            }
        }
    

