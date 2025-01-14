//
//  TabBarView.swift
//  MarketApp
//
//  Created by Mikayil on 11.01.25.
//

import UIKit

class TabBarView: UITabBar {
    

    private var shapeLayer: CAShapeLayer?
    var centeredWith:CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        centeredWith = self.bounds.width / 0
        self.unselectedItemTintColor = .black
        self.tintColor = .black
        self.addShape()
    }
    private func addShape () {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = getPath()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.2
        
        
        if let oldShape = self.shapeLayer {
            self.layer.replaceSublayer(oldShape, with: shapeLayer)
        }else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
 
    private func getPath() -> CGPath {
        let height:CGFloat = 47
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centeredWith - height * 2 , y : 0))
        path.addCurve(
            to: CGPoint(x: centeredWith, y: height),
            controlPoint1: CGPoint(x: centeredWith - 30, y: 0),
            controlPoint2: CGPoint(x: centeredWith - 35, y: height))
        
        
        path.addCurve(
            to: CGPoint(x: centeredWith + height * 2, y: 0),
            controlPoint1: CGPoint(x: centeredWith + 35, y: height),
            controlPoint2: CGPoint(x: centeredWith + 30, y: 0))
        
        path.addLine(to: CGPoint(x: self.bounds.width, y : 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y : self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y : self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y : 0))
        path.close()
        return path.cgPath
        
    }
    func updateCurveForTappedIndex() {
        guard let selectedTabView = self.selectedItem?.value(forKey: "view") as? UIView else { return }
        self.centeredWith = selectedTabView.frame.origin.x + (selectedTabView.frame.width / 2)
        
        addShape()
    }
}
