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

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.4235294118, green: 0.3009306788, blue: 0.4103954434, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.9719236493, green: 0.4874661565, blue: 0.4658593535, alpha: 1) {
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
