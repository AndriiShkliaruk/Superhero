//
//  UIView+Nib.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 18.03.2022.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    class func showWithTransition(childView: UIView, in parentView: UIView) {
        Self.transition(with: parentView, duration: 0.5, options: [.curveEaseOut], animations: {
            parentView.addSubview(childView)
        }, completion: nil)
    }
    
    class func hideWithTransition(childView: UIView, from parentView: UIView) {
        Self.transition(with: parentView, duration: 0.5, options: [.curveEaseOut], animations: {
            childView.removeFromSuperview()
        }, completion: nil)
    }
}
