//
//  OnboardingController.swift
//  MarketApp
//
//  Created by Mikayil on 06.01.25.
//

import UIKit

class OnboardingController: UIViewController {
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageeControl: UIPageControl!

    let titleArray = [
        "1 touch trading",
        "as soon as possible",
        "enough for your money"
    ]
    let subtitleArray = [
        "at your doorstep as soon as possible",
        "wherever you want with just 1 touch",
        "high quality and cheaper and abundant products with discounts"
    ]
    let imageArray = [
        ImageHelper.art1,
        ImageHelper.art2,
        ImageHelper.art3
    ]
    
    
    
    }
extension OnboardingController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageeControl.numberOfPages = titleArray.count
        pageeControl.currentPage = 0
        skipShow(true)
        signupLoginShow(false)
    }

}
extension OnboardingController {
    @IBAction func skipButtonAction(_ sender: UIButton) {
        let lastIndex = titleArray.count - 1
            let indexPath = IndexPath(item: lastIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageeControl.currentPage = lastIndex
            signupLoginShow(true)
        }
    @IBAction func signupButtonAction(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
        
    }
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
        
    }
    @IBAction func pageValeuChanged(_ sender: Any) {
        let indexPath = IndexPath(item: pageeControl.currentPage, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
extension OnboardingController {
    private func skipShow(_ bool: Bool) {
        skipButton.isHidden = !bool
        signupButton.isHidden = bool
        loginButton.isHidden = bool
    }
    private func signupLoginShow(_ show: Bool) {
        signupButton.isHidden = !show
        loginButton.isHidden = !show
    }

}
extension OnboardingController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.artImageView.image = imageArray[indexPath.row]
        cell.headingLabel.text = titleArray[indexPath.row]
        cell.subHeadingLabel.text = subtitleArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
           let currentPage = Int(scrollView.contentOffset.x / pageWidth)
           pageeControl.currentPage = currentPage
           if currentPage == 2 {
               skipShow(false)
               signupLoginShow(true)
           } else {
               skipShow(true)
               signupLoginShow(false)
           }
       }
    }
    
    extension UIPageControl {
        var page: Int {
            get {
                return currentPage
            }
            set {
                currentPage = max(0, min(newValue, numberOfPages - 1))
            }
        }
    }



   
