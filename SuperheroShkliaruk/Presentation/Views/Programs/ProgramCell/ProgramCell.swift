//
//  ProgramCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 22.04.2022.
//

import UIKit

class ProgramCell: UITableViewCell {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    
    static let identifier = "ProgramCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        innerView.backgroundColor = .clear
        innerView.layer.cornerRadius = innerView.frame.height / 2
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.white.cgColor
        titleLabel.font = .sairaRegularWithSize16
        titleLabel.textColor = .white
    }
    
    func configure(with viewModel: ProgramViewModel) {
        titleLabel.text = viewModel.titleLabelText
        arrowImageView.image = UIImage(named: viewModel.arrowImage)
    }

}
