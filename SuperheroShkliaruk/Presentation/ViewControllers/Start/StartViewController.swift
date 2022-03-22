//
//  StartViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 15.02.2022.
//

import UIKit

class StartViewController: UIViewController, Storyboarded {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var superheroLabel: UILabel!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var maleButton: CustomRoundedButton!
    @IBOutlet weak var femaleButton: CustomRoundedButton!
    @IBOutlet weak var maleImageView: UIImageView!
    @IBOutlet weak var femaleImageView: UIImageView!
    
    private let viewModel = StartViewModel()
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        gradientView.applyBlackVerticalGradient()
        
        superheroLabel.text = viewModel.titleLabelText.uppercased()
        superheroLabel.textColor = .customYellow
        superheroLabel.font = .futuraBoldWithSize32
        
        chooseLabel.text = viewModel.subtitleLabelText
        chooseLabel.textColor = .white
        chooseLabel.font = .sairaRegularWithSize16
        
        maleImageView.image = UIImage(named: viewModel.manImageName)
        maleButton.setTitle(viewModel.maleButtonText.uppercased(), for: .normal)
        maleButton.backgroundColor = .customYellow
        maleButton.titleLabel?.font = .sairaRegularWithSize18
        
        femaleImageView.image = UIImage(named: viewModel.womanImageName)
        femaleButton.setTitle(viewModel.femaleButtonText.uppercased(), for: .normal)
        femaleButton.backgroundColor = .customYellow
        femaleButton.titleLabel?.font = .sairaRegularWithSize18
    }
    
    @IBAction func chooseCharacterButtonTapped(_ sender: UIButton) {
        let sex = Sex.getStringValueByTag(sender.tag)
        viewModel.createNewUserWithSex(sex)
        coordinator?.moveToHome()
    }
}
