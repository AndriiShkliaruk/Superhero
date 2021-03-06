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
    
    //MARK: - Futura
    public class var futuraBoldWithSize32: UIFont {
        return customFont(name: "Futura-Bold", size: 32)
    }
    
    //MARK: - Saira
    public class var sairaRegularWithSize16: UIFont {
        return customFont(name: "Saira-Regular", size: 16)
    }
    
    public class var sairaRegularWithSize18: UIFont {
        return customFont(name: "Saira-Regular", size: 18)
    }
    
    public class var sairaRegularWithSize24: UIFont {
        return customFont(name: "Saira-Regular", size: 24)
    }
    
    public class var sairaMediumWithSize16: UIFont {
        return customFont(name: "Saira-Medium", size: 16)
    }
    
    public class var sairaMediumWithSize18: UIFont {
        return customFont(name: "Saira-Medium", size: 18)
    }
    
    public class var sairaMediumWithSize24: UIFont {
        return customFont(name: "Saira-Medium", size: 24)
    }
    
    public class var sairaLightWithSize16: UIFont {
        return customFont(name: "Saira-Light", size: 16)
    }
    
    //MARK: - Helvetica Neue
    public class var helveticaNeueRegularWithSize16: UIFont {
        return customFont(name: "HelveticaNeue", size: 16)
    }
    
    public class var helveticaNeueRegularWithSize18: UIFont {
        return customFont(name: "HelveticaNeue", size: 18)
    }
    
    public class var helveticaNeueRegularWithSize20: UIFont {
        return customFont(name: "HelveticaNeue", size: 20)
    }
    
    public class var helveticaNeueThinWithSize18: UIFont {
        return customFont(name: "HelveticaNeue-Thin", size: 18)
    }
    
    public class var helveticaNeueMediumWithSize18: UIFont {
        return customFont(name: "HelveticaNeue-Medium", size: 18)
    }
    
    public class var helveticaNeueBoldWithSize24: UIFont {
        return customFont(name: "HelveticaNeue-Bold", size: 24)
    }
    
    //MARK: - Gilroy
    public class var gilroySemiboldWithSize12: UIFont {
        return customFont(name: "Gilroy-Semibold", size: 12)
    }
    
    public class var gilroySemiboldWithSize14: UIFont {
        return customFont(name: "Gilroy-Semibold", size: 14)
    }
    
    //MARK: - Nunito
    public class var nunitoLightWithSize14: UIFont {
        return customFont(name: "Nunito-Light", size: 14)
    }
    
    public class var nunitoLightWithSize16: UIFont {
        return customFont(name: "Nunito-Light", size: 16)
    }
    
    public class var nunitoSemiboldWithSize14: UIFont {
        return customFont(name: "Nunito-SemiBold", size: 14)
    }
}
