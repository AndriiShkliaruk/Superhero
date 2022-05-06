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
    
    func showButtonOnKeyboard(_ button: UIBarButtonItem) {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .highlighted)
        
        let items = [flexSpace, button]
        toolbar.items = items
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
}
