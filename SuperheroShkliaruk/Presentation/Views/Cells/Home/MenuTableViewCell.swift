//
//  MenuTableViewCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    static let identifier = "MenuTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        underlineView.backgroundColor = .white
        titleLabel.textColor = .white
    }
    
    func configure(with text: String) {
        titleLabel.text = text
        titleLabel.font = .helveticaNeueRegularWithSize18
    }
}
