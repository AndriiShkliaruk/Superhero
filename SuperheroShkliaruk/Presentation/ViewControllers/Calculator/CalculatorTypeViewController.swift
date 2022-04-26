//
//  CalculatorTypeViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 26.04.2022.
//

import UIKit

class CalculatorTypeViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var parametersStackView: UIStackView!
    @IBOutlet private weak var chooseActivityButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var resultUnitsLabel: UILabel!
    @IBOutlet private weak var calculateButtonView: CustomRoundedButtonView!
    
    var coordinator: MainCoordinator?
    var viewModel: CalculatorTypeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //title = viewModel.navigationBarTitleText
        titleLabel.font = .sairaMediumWithSize24
        titleLabel.textColor = .white
        
        
        
        chooseActivityButton.titleLabel?.font = .sairaRegularWithSize16
        chooseActivityButton.titleLabel?.textColor = .white
        chooseActivityButton.layer.borderWidth = 1
        chooseActivityButton.layer.borderColor = UIColor.white.cgColor
        chooseActivityButton.layer.cornerRadius = chooseActivityButton.frame.height / 2
        
        resultLabel.font = .sairaSemiBoldWithSize28
        resultLabel.textColor = .customYellow
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor(white: 1, alpha: 0.4).cgColor
        resultLabel.layer.cornerRadius = 8
        
        resultUnitsLabel.font = .sairaLightWithSize18
        resultUnitsLabel.textColor = .white
    }
}
