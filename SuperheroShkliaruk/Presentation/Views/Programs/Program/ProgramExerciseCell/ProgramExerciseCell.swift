//
//  ProgramExerciseCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 18.04.2022.
//

import UIKit

class ProgramExerciseCell: UITableViewCell {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var optionsLabel: UILabel!
    
    static let identifier = "ProgramExerciseCell"
    private var viewModel: ExerciseViewModel?
    var coordinator: ProgramsCoordinator?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.autoresizingMask = .flexibleHeight
        backgroundColor = .clear
        innerView.backgroundColor = .clear
        
        titleLabel.font = .sairaRegularWithSize18
        titleLabel.textColor = .white
        
        optionsLabel.font = .nunitoLightWithSize14
        optionsLabel.textColor = .customYellow
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        innerView.addGestureRecognizer(tapGesture)
    }
    
    func configure(with viewModel: ExerciseViewModel) {
        self.viewModel = viewModel
        iconImageView.image = UIImage(named: viewModel.icon)
        titleLabel.text = viewModel.name
        optionsLabel.text = viewModel.options
    }
    
    @objc private func cellTapped() {
        guard let viewModel = viewModel else { return }
        coordinator?.moveToExercise(with: viewModel)
    }
}
