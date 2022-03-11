//
//  UIFont+CustomFonts.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

extension UIFont {
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    public class var futuraBoldWithSize32: UIFont {
        return customFont(name: "Futura-Bold", size: 32)
    }
    
    public class var sairaRegularWithSize16: UIFont {
        return customFont(name: "Saira-Regular", size: 16)
    }
    
    public class var sairaRegularWithSize18: UIFont {
        return customFont(name: "Saira-Regular", size: 18)
    }
    
    public class var sairaRegularWithSize24: UIFont {
        return customFont(name: "Saira-Regular", size: 24)
    }
    
    public class var sairaMediumWithSize18: UIFont {
        return customFont(name: "Saira-Medium", size: 18)
    }
    
    public class var sairaLightWithSize16: UIFont {
        return customFont(name: "Saira-Light", size: 16)
    }
    
    public class var helveticaNeueRegularWithSize18: UIFont {
        return customFont(name: "HelveticaNeue", size: 18)
    }
    
    public class var helveticaNeueThinWithSize18: UIFont {
        return customFont(name: "HelveticaNeue-Thin", size: 18)
    }
}
