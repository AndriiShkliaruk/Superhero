//
//  ActivityLevelCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 28.04.2022.
//

import UIKit

class ActivityLevelCell: UITableViewCell {
    @IBOutlet private weak var optionImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    static let identifier = "ActivityLevelCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        nameLabel.font = .helveticaNeueRegularWithSize16
        nameLabel.textColor = .white
    }
    
    func configure(name: String, icon: String) {
        nameLabel.text = name
        optionImageView.image = UIImage(named: icon)
    }
}
