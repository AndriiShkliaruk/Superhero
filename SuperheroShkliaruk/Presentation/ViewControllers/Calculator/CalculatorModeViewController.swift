//
//  CalculatorModeViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 26.04.2022.
//

import UIKit

class CalculatorModeViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sexSegmentedControl: CustomSegmentedControl!
    @IBOutlet private weak var parametersStackView: UIStackView!
    @IBOutlet private weak var chooseActivityButton: UIButton!
    @IBOutlet private weak var resultStackView: UIStackView!
    @IBOutlet private weak var resultValueLabel: UILabel!
    @IBOutlet private weak var resultDescriptionLabel: UILabel!
    @IBOutlet private weak var calculateButtonView: CustomRoundedButtonView!
    
    private lazy var transitionDelegate = DimmTransitionManager()
    var coordinator: CalculatorCoordinator?
    var viewModel: CalculatorModeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        setupUI(with: viewModel)
        configureInputs(with: viewModel)
        configureUI(for: viewModel.mode)
    }
    
    private func setupUI(with viewModel: CalculatorModeViewModel) {
        title = viewModel.navigationBarTitleText
    
        titleLabel.font = .sairaMediumWithSize24
        titleLabel.textColor = .white
        titleLabel.text = viewModel.titleLabelText
        
        parametersStackView.backgroundColor = .clear
        
        sexSegmentedControl.font = .helveticaNeueRegularWithSize18
        sexSegmentedControl.borderWidth = 1
        sexSegmentedControl.borderColor = .customYellow
        sexSegmentedControl.cornerRadius = sexSegmentedControl.frame.height / 2
        sexSegmentedControl.textColor = .customYellow
        sexSegmentedControl.selectorTextColor = .black
        sexSegmentedControl.backgroundColor = .clear
        sexSegmentedControl.selectorColor = .customYellow
        sexSegmentedControl.segmentedTitles = viewModel.segmentedControlItems
        
        chooseActivityButton.titleLabel?.font = .sairaRegularWithSize16
        chooseActivityButton.titleLabel?.textColor = .white
        chooseActivityButton.layer.borderWidth = 1
        chooseActivityButton.layer.borderColor = UIColor.white.cgColor
        chooseActivityButton.layer.cornerRadius = chooseActivityButton.frame.height / 2
        chooseActivityButton.setTitle(viewModel.chooseActivityButtonText, for: .normal)
        
        resultValueLabel.font = .sairaSemiBoldWithSize28
        resultValueLabel.textColor = .customYellow
        resultValueLabel.layer.borderWidth = 1
        resultValueLabel.layer.borderColor = UIColor(white: 1, alpha: 0.4).cgColor
        resultValueLabel.layer.cornerRadius = 8
        
        resultDescriptionLabel.font = .sairaLightWithSize18
        resultDescriptionLabel.textColor = .white
        setResultIsHidden(true)
        
        calculateButtonView.setButtonTitle(viewModel.calculateButtonText)
        calculateButtonView.setButtonActionOnTap(calculateButtonTapped)
        calculateButtonView.setButtonIsEnabled(false)
    }
    
    private func configureUI(for mode: CalculatorMode) {
        switch mode {
        case .bmi:
            sexSegmentedControl.removeFromSuperview()
            chooseActivityButton.removeFromSuperview()
        case .fatPercentage:
            updateHipsInputViewVisibility(sexSegmentedControl.selectedSegmentIndex)
            chooseActivityButton.removeFromSuperview()
        case .dailyCalorie:
            break
        }
    }
    
    private func configureInputs(with viewModel: CalculatorModeViewModel) {
        viewModel.parameterInputs.forEach { input in
            let inputView: CalculatorParameterView = CalculatorParameterView.fromNib()
            inputView.configure(input.name, units: input.units)
            inputView.delegate = self
            parametersStackView.addArrangedSubview(inputView)
        }
        parametersStackView.layoutIfNeeded()
    }
    
    private func calculateButtonTapped() {
        setResultIsHidden(false)
        viewModel?.didCalculateTap()
        resultValueLabel.text = viewModel?.stringResultValue
        resultDescriptionLabel.text = viewModel?.resultDescription
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    private func updateHipsInputViewVisibility(_ selectedIndex: Int) {
        guard let inputViews = parametersStackView.arrangedSubviews as? [CalculatorParameterView] else { return }
        guard let hipsInputView = inputViews.first(where: { $0.inputMode == .hips }) else { return }
        hipsInputView.isHidden = selectedIndex == 0 ? true : false
    }
    
    private func setResultIsHidden(_ isHidden: Bool) {
        resultStackView.isHidden = isHidden
        scrollView.isScrollEnabled = !isHidden
    }
    
    @IBAction func sexSegmentedControlValueChanged(_ sender: CustomSegmentedControl) {
        guard let viewModel = viewModel else { return }
        viewModel.changeSex(sender.selectedSegmentIndex)
        calculateButtonView.setButtonIsEnabled(viewModel.isCalculateButtonEnabled)

        if viewModel.mode == .fatPercentage {
            updateHipsInputViewVisibility(sender.selectedSegmentIndex)
        }
        scrollView.setContentOffset(.zero, animated: true)
        setResultIsHidden(true)
    }
    
    
    @IBAction func chooseActivityButtonTapped(_ sender: UIButton) {
        coordinator?.presentRateActivities { viewController in
            viewController.delegate = self
            viewController.viewModel = viewModel?.activityLevelViewModel
            viewController.transitioningDelegate = transitionDelegate
            viewController.modalPresentationStyle = .custom
        }
    }
}

extension CalculatorModeViewController: CalculatorModeViewControllerDelegate {
    func didTapConfirm() {
        viewModel?.updateActivityLevel()
        coordinator?.dismiss(animated: true)
        chooseActivityButton.setTitle(viewModel?.activityLevelViewModel.selectedItem?.description, for: .normal)
    }
    
    func didTapClose() {
        coordinator?.dismiss(animated: true)
    }
    
    func didChangeParameter(_ inputMode: CalculatorParameter, newValue: String) {
        guard let viewModel = viewModel else { return }
        viewModel.changeParameter(inputMode, newValue: newValue)
        calculateButtonView.setButtonIsEnabled(viewModel.isCalculateButtonEnabled)
    }
}
