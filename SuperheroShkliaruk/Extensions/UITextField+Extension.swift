//
//  UITextField+Extension.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 11.03.2022.
//

import UIKit

extension UITextField {
    func underlined(withColor color: UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.size.height + 11, width: frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.insertSublayer(bottomLine, at: 0)
    }
    
    func changeUnderlineColor(_ color: UIColor) {
        guard let underline = layer.sublayers?[0] else { return }
        underline.backgroundColor = color.cgColor
    }
    
    func configurePlaceholder(withText text: String, font: UIFont, textColor: UIColor) {
        attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: font,
                                                                              .foregroundColor: textColor])
    }
}
