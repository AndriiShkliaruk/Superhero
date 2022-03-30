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


//MARK: - Done button on keyboard

extension UITextField {
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.resignFirstResponder))
        done.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        done.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .highlighted)
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
