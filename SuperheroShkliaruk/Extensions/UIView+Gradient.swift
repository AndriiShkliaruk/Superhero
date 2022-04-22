//
//  UIView+Gradient.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

extension UIView {
    func applyBlackVerticalGradient() {
        let clear = UIColor(white: 0, alpha: 0).cgColor
        let halfBlack = UIColor(white: 0, alpha: 0.83).cgColor
        let black = UIColor(white: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [clear, halfBlack, black, halfBlack, clear]
        gradient.locations = [0.0, 0.30, 0.5, 0.65, 1]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    func applyBlackTopGradient() {
        let clear = UIColor(white: 0, alpha: 0).cgColor
        let black = UIColor(white: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [clear, black, black]
        gradient.locations = [0.0, 0.2, 1]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    func applyBlackRadialGradient() {
        let clear = UIColor(white: 0, alpha: 0).cgColor
        let black = UIColor(white: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [clear, black]
        gradient.startPoint = CGPoint(x: 0.45, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.15, y: 0.9)
        gradient.frame = frame
        gradient.opacity = 0.58
        layer.addSublayer(gradient)
    }
}
