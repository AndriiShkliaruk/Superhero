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
    
    var mode: ExercisesMode = .normal
    var viewModel: ExerciseViewModel?
    var coordinator: MusclesCoordinator?
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
        
        switch mode {
        case .normal:
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
            addButtonView.setButtonTitle(viewModel.addButtonTitle)
            addButtonView.setButtonActionOnTap(addButtonTapped)
        case .edit:
            addButtonView.isHidden = true
        }
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
            self?.coordinator?.createProgram(with: viewModel)
        }))
    }
    
    private func addButtonTapped() {
        showActionSheetWithCancel(with: actionSheetItems)
    }
}
