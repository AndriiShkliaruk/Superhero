//
//  CustomRoundedButton.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

class CustomRoundedButton: UIButton {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = layer.frame.height / 2
        titleLabel?.textColor = .black
        tintColor = .black
    }
}
