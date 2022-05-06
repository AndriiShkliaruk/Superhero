//
//  ProgramsCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 05.05.2022.
//

import UIKit

class ProgramsCoordinator: BaseCoordinator, Coordinator {
    private lazy var musclesCoordinator: MusclesCoordinator = MusclesCoordinator(navigationController)

    func start() {
        let viewController = ProgramsViewController.instantiate()
        viewController.coordinator = self
        pushViewController(viewController, animated: true)
    }
    
    func moveToProgram(with mode: ProgramMode) {
        let viewController = ProgramViewController.instantiate()
        viewController.coordinator = self
        switch mode {
        case .create(let exercise):
            viewController.viewModel = ProgramViewModel(mode: .create(initialExercise: exercise))
        case .edit(let program):
            viewController.viewModel = ProgramViewModel(mode: .edit(inputProgram: program))
        }
        pushViewController(viewController, animated: true)
    }
    
    func moveToMuscles(with mode: ExercisesMode, delegate: ProgramViewControllerDelegate, viewModel: MusclesViewModel) {
        musclesCoordinator.start(with: mode, delegate: delegate, viewModel: viewModel)
    }
    
    func moveToExercise(with viewModel: ExerciseViewModel) {
        musclesCoordinator.moveToExercise(with: .edit, viewModel: viewModel)
    }
}


