//
//  GradientView.swift
//  SlackCloneApp
//
//  Created by Burak Tunc on 19.06.2020.
//  Copyright © 2020 Burak Tunç. All rights reserved.
//
//  Custom Gradient View

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.3921568627, green: 0.3019607843, blue: 0.4039215686, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.9254901961, green: 0.5176470588, blue: 0.4862745098, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer() // Core Animation Gradient Layer
        //gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor, topColor.cgColor] // 3 colors Gradient
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor] // 2 colors Gradient
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
