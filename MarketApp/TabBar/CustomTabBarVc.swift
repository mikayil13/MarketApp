//
//  CustomTabBarVc.swift
//  MarketApp
//
//  Created by Mikayil on 11.01.25.
//

import UIKit

class CustomTabBarVc: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 0
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabbar = tabBar as? TabBarView {
            tabbar.updateCurveForTappedIndex()
       
               }
           }
       }
