//
//  UIButton+RoundedCorners.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

extension UIButton {
    public func makeRoundedCorners() {
        self.layer.cornerRadius = layer.frame.height/2
    }
}
