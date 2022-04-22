//
//  CustomRoundedButtonView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 12.04.2022.
//

import UIKit

class CustomRoundedButtonView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var button: CustomRoundedButton!
    
    private var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self)
        backgroundColor = .clear
        contentView.applyBlackTopGradient()
        addSubview(contentView)
        button.backgroundColor = .customYellow
        button.titleLabel?.font = .sairaRegularWithSize16
    }
    
    func setButtonTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }
    
    func setButtonActionOnTap(_ action: @escaping () -> Void) {
        buttonAction = action
    }
    
    @IBAction func buttonTapped(_ sender: CustomRoundedButton) {
        buttonAction?()
    }
}
