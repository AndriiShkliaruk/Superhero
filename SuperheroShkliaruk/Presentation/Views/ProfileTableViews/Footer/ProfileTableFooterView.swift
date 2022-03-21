//
//  ProfileTableFooterView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 14.03.2022.
//

import UIKit

class ProfileTableFooterView: UITableViewHeaderFooterView {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    static let identifier = "ProfileTableFooterView"
    
    public func setupUI(_ viewModel: ProfileViewModel) {
        descriptionLabel.text = viewModel.descriptionLabelText
        descriptionLabel.font = .sairaLightWithSize16
        descriptionLabel.textColor = .customGray
    }
}
