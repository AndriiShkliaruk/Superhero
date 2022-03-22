//
//  UIView+Gradient.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

extension UIView {
    public func applyBlackVerticalGradient() {
        let clear = UIColor(white: 0, alpha: 0).cgColor
        let halfBlack = UIColor(white: 0, alpha: 0.83).cgColor
        let black = UIColor(white: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [clear, halfBlack, black, halfBlack, clear]
        gradient.locations = [0.0, 0.30, 0.5, 0.65, 1]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
    
    public func applyBlackTopGradient() {
        let clear = UIColor(white: 0, alpha: 0).cgColor
        let black = UIColor(white: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [clear, black, black]
        gradient.locations = [0.0, 0.2, 1]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
