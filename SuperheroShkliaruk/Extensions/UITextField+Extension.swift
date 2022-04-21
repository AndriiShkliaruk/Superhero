//
//  UITextField+Extension.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 11.03.2022.
//

import UIKit

extension UITextField {
    var isTextEmpty: Bool {
        if text != nil && text != "" {
            return false
        } else {
            return true
        }
    }
    
    func configurePlaceholder(withText text: String, font: UIFont, textColor: UIColor) {
        attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: font,
                                                                              .foregroundColor: textColor])
    }
}

