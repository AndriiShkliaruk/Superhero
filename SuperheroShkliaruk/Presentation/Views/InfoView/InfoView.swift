//
//  InfoView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 30.03.2022.
//

import UIKit

class InfoView: UIView {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var infoIconImageView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.65)
        innerView.backgroundColor = .black
        innerView.layer.cornerRadius = 8
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.white.cgColor
        infoLabel.font = .helveticaNeueRegularWithSize16
        infoLabel.textColor = .white
    }
    
    func configure(with icon: UIImage, text: String) {
        infoIconImageView.image = icon
        infoLabel.text = text
    }
}
