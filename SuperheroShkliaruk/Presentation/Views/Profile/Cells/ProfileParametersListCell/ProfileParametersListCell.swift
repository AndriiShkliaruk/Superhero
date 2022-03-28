//
//  ProfileParametersListCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import UIKit

class ProfileParametersListCell: UITableViewCell {
    @IBOutlet private weak var checkboxImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    static let identifier = "ProfileParametersListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        titleLabel.font = .sairaRegularWithSize18
        titleLabel.textColor = .white
    }
    
    public func configure(with viewModel: ParameterViewModel) {
        titleLabel.text = viewModel.title
        checkboxImageView.image = UIImage(named: viewModel.checkboxImageName)
    }
}
