//
//  MusclesCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 05.05.2022.
//

import UIKit

class MusclesCoordinator: BaseCoordinator, Coordinator {
    var parentCoordinator: TabBarCoordinator?
    
    init(_ navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MusclesViewController.instantiate()
        viewController.coordinator = self
        pushViewController(viewController, animated: true)
    }
    
    func start(with mode: ExercisesMode, delegate: ProgramViewControllerDelegate, viewModel: MusclesViewModel) {
        let viewController = MusclesViewController.instantiate()
        viewController.mode = mode
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewController.delegate = delegate
        pushViewController(viewController, animated: true)
    }
    
    func moveToExercise(with mode: ExercisesMode, viewModel: ExerciseViewModel) {
        let viewController = ExerciseViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewController.mode = mode
        pushViewController(viewController, animated: true)
    }
    
    func createProgram(with exercise: ExerciseViewModel) {
        navigationController.popViewController(animated: false)
        parentCoordinator?.selectTab(.programs)
        parentCoordinator?.programsCoordinator.moveToProgram(with: .create(initialExercise: exercise))   
    }
}
