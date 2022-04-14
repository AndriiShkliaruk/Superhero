//
//  ExerciseCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 09.04.2022.
//

import UIKit

class ExerciseCell: UITableViewCell {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var optionsLabel: UILabel!
    @IBOutlet private weak var moreButton: UIButton!
    @IBOutlet private weak var checkboxImageView: UIImageView!
    
    static let identifier = "ExerciseCell"
    private var viewModel: ExerciseViewModel?
    var delegate: ExerciseCellDelegate?
    var coordinator: MainCoordinator?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.autoresizingMask = .flexibleHeight
        backgroundColor = .clear
        innerView.backgroundColor = .clear
        innerView.layer.cornerRadius = 8
        
        titleLabel.font = .sairaRegularWithSize18
        titleLabel.textColor = .white
        
        optionsLabel.font = .nunitoLightWithSize14
        optionsLabel.textColor = .customYellow
        
        moreButton.titleLabel?.font = .nunitoLightWithSize16
        moreButton.setTitleColor(.customYellow, for: .normal)
        moreButton.tintColor = .customYellow
        moreButton.semanticContentAttribute = .forceRightToLeft
    }
    
    func configure(with viewModel: ExerciseViewModel, for mode: MusclesViewControllerMode) {
        self.viewModel = viewModel
        
        iconImageView.image = UIImage(named: viewModel.icon)
        titleLabel.text = viewModel.name
        optionsLabel.text = viewModel.options
        moreButton.setTitle(viewModel.moreButtonText, for: .normal)
        
        let arrow = UIImage(named: viewModel.moreButtonIcon)
        moreButton.setImage(arrow, for: .normal)
        moreButton.imageView?.contentMode = .scaleAspectFit
        moreButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 2)
        setCellSelection()
        
        guard mode == .edit else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        innerView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {
        viewModel?.isSelected.toggle()
        setCellSelection()
        delegate?.changeSelectedCount()
    }
    
    private func setCellSelection() {
        guard let isSelected = viewModel?.isSelected else { return }
        if isSelected {
            innerView.layer.borderWidth = 2
            innerView.layer.borderColor = UIColor.customYellow.cgColor
            checkboxImageView.isHidden = false
        } else {
            innerView.layer.borderWidth = 1
            innerView.layer.borderColor = UIColor(white: 1, alpha: 0.4).cgColor
            checkboxImageView.isHidden = true
        }
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        coordinator?.moveToExercise(with: viewModel)
    }
}
