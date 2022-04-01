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
        innerView.backgroundColor = .black
        innerView.layer.cornerRadius = 8
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.white.cgColor
        infoLabel.font = .helveticaNeueRegularWithSize16
        infoLabel.textColor = .white
    }
    
    func configure(with icon: UIImage, text: String, backgroundColor: UIColor?) {
        infoIconImageView.image = icon
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        infoLabel.attributedText = attrString
        
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        } else {
            self.backgroundColor = UIColor(white: 0, alpha: 0.65)
        }
    }
}
