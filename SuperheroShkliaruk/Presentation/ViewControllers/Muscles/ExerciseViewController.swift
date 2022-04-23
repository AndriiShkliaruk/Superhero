//
//  ExerciseViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 12.04.2022.
//

import UIKit

class ExerciseViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var optionsLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var addButtonView: CustomRoundedButtonView!
    
    var viewModel: ExerciseViewModel?
    var coordinator: MainCoordinator?
    private var actionSheetItems = [ActionSheetItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        scrollView.backgroundColor = .black
        coverImageView.applyBlackRadialGradient()
        titleLabel.font = .sairaRegularWithSize18
        titleLabel.textColor = .white
        optionsLabel.font = .nunitoLightWithSize14
        optionsLabel.textColor = .customYellow
        descriptionLabel.font = .sairaLightWithSize16
        descriptionLabel.textColor = .customGray
        
        guard let viewModel = viewModel else { return }
        title = viewModel.navigationBarTitle
        configureActionSheet(viewModel)
        
        coverImageView.image = UIImage(named: viewModel.image)
        iconImageView.image = UIImage(named: viewModel.icon)
        titleLabel.text = viewModel.name
        optionsLabel.text = viewModel.options
        descriptionLabel.text = viewModel.description
        addButtonView.setButtonTitle(viewModel.addButtonTitle)
        addButtonView.setButtonActionOnTap(addButtonTapped)
    }
    
    private func setupNavigationBar() {
        navigationItem.backButtonTitle = viewModel?.backButtonText
    }
    
    private func configureActionSheet(_ viewModel: ExerciseViewModel) {
        actionSheetItems = viewModel.getAvailablePrograms().map { [weak self] program in
            (program.name, {
                viewModel.addExercise(to: program)
                self?.coordinator?.backWithInfoView(iconName: program.infoIconName, text: program.exerciseAddedInfoText)
            })
        }
        actionSheetItems.append((viewModel.newProgramActionTitle, { [weak self] in
            self?.coordinator?.moveToProgram(with: .create(initialExercise: viewModel))
        }))
    }
    
    private func addButtonTapped() {
        showActionSheetWithCancel(with: actionSheetItems)
    }
}
