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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        descriptionLabel.font = .sairaLightWithSize16
        descriptionLabel.textColor = .customGray
    }
    
    func configure(with viewModel: ProfileViewModel) {
        descriptionLabel.text = viewModel.descriptionLabelText
        
    }
}
