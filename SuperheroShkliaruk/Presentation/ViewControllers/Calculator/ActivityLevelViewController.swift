//
//  ActivityLevelViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 28.04.2022.
//

import UIKit

class ActivityLevelViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeImageView: UIImageView!
    @IBOutlet private weak var optionsStackView: UIStackView!
    @IBOutlet private weak var confirmButton: UIButton!
    
    var viewModel: ActivityLevelViewModel?
    var delegate: CalculatorModeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setActivityItems()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        innerView.backgroundColor = .black
        innerView.layer.cornerRadius = 8
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.white.cgColor
        
        titleLabel.font = .helveticaNeueRegularWithSize16
        titleLabel.textColor = .white
        titleLabel.text = viewModel?.activityLevelTitleLabelText
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeImageViewTapped))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
        
        optionsStackView.backgroundColor = .clear
        
        confirmButton.titleLabel?.font = .sairaRegularWithSize16
        confirmButton.tintColor = .black
        confirmButton.layer.cornerRadius = confirmButton.frame.height / 2
        confirmButton.backgroundColor = .customYellow
        confirmButton.setTitle(viewModel?.confirmButtonText, for: .normal)
    }
    
    private func setActivityItems() {
        guard let viewModel = viewModel else { return }
        viewModel.activityItems.forEach { activityLevel in
            let levelView: ActivityLevelItemView = ActivityLevelItemView.fromNib()
            levelView.configure(item: activityLevel, icon: viewModel.icon(for: activityLevel))
            levelView.delegate = self
            optionsStackView.addArrangedSubview(levelView)
        }
        optionsStackView.layoutIfNeeded()
    }
    
    private func updateActivityItems() {
        optionsStackView.subviews.forEach { $0.removeFromSuperview() }
        setActivityItems()
    }
    
    @objc private func closeImageViewTapped() {
        viewModel?.resetSelectedItem()
        delegate?.didTapClose()
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        viewModel?.confirmSelectedItem()
        delegate?.didTapConfirm()
    }
}

extension ActivityLevelViewController: ActivityLevelViewControllerDelegate {
    func didSelectItem(_ item: DailyCaloriesRateAtivityLevel) {
        viewModel?.setSelectedItem(item)
        updateActivityItems()
    }
}
