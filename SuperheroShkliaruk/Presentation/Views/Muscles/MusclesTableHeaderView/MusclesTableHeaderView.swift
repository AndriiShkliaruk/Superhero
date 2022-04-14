//
//  MusclesTableHeaderView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 09.04.2022.
//

import UIKit

class MusclesTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var chevronImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var selectedStackView: UIStackView!
    @IBOutlet private weak var selectedLabel: UILabel!
    @IBOutlet private weak var selectedCountLabel: UILabel!
    
    static let identifier = "MusclesTableHeaderView"
    private var viewModel: MuscleGroupViewModel?
    var tapClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.font = .helveticaNeueRegularWithSize18
        titleLabel.textColor = .white
        
        selectedLabel.font = .nunitoLightWithSize14
        selectedLabel.textColor = .white
        
        selectedCountLabel.font = .nunitoSemiboldWithSize14
        selectedCountLabel.textColor = .customYellow
        
        innerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        innerView.addGestureRecognizer(tapGesture)
    }
    
    func configure(with viewModel: MuscleGroupViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.name
        chevronImageView.image = UIImage(named: viewModel.chevronIcon)
        setSelectedCount()
        setChevronDirection()
    }
    
    func setSelectedCount() {
        guard let count = viewModel?.selectedExercisesCount else { return }
        selectedCountLabel.text = count
        selectedStackView.isHidden = Int(count) == 0
    }
    
    @objc private func headerTapped(_ sender: UITapGestureRecognizer) {
        tapClosure?()
        setChevronDirection()
    }
    
    private func setChevronDirection() {
        guard let isUp = viewModel?.isOpen else { return }
        chevronImageView.transform = transform.rotated(by: isUp ? .pi : 0)
    }
}
