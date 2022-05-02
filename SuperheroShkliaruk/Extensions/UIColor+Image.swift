//
//  UIColor+Image.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 02.05.2022.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
