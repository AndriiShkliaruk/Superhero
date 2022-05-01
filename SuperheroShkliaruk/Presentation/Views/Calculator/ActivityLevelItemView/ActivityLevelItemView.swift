//
//  ActivityLevelItemView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 30.04.2022.
//

import UIKit

class ActivityLevelItemView: UIView {
    @IBOutlet private weak var optionImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var activityItem: DailyCaloriesRateAtivityLevel?
    var delegate: ActivityLevelViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        nameLabel.font = .helveticaNeueRegularWithSize16
        nameLabel.textColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    func configure(item: DailyCaloriesRateAtivityLevel, icon: String) {
        activityItem = item
        nameLabel.text = item.description
        optionImageView.image = UIImage(named: icon)
    }
    
    @objc private func itemTapped() {
        guard let item = activityItem else { return }
        delegate?.didSelectItem(item)
    }
}
