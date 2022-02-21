//
//  UIView+Gradient.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

extension UIView {
    public func applyBlackGradientInForeground() {
        let transparent = UIColor(red: 0, green: 0, blue: 0, alpha: 0.00).cgColor
        let halfBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.83).cgColor
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [transparent, halfBlack, black, halfBlack, transparent]
        gradient.locations = [0.0, 0.30, 0.5, 0.65, 1]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
