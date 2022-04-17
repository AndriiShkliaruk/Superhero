//
//  UITextField+Extension.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 11.03.2022.
//

import UIKit

extension UITextField {
    func configurePlaceholder(withText text: String, font: UIFont, textColor: UIColor) {
        attributedPlaceholder = NSAttributedString(string: text, attributes: [.font: font,
                                                                              .foregroundColor: textColor])
    }
    
    func updateUnderlineColor(underlineView: UIView) {
        if text != nil && text != "" {
            underlineView.backgroundColor = .customDarkYellow
        } else {
            underlineView.backgroundColor = .white
        }
    }
}

