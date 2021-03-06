//
//  Coordinator+Muscles.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

extension MainCoordinator {
    func moveToMuscles() {
        let viewController = MusclesViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToExercise(with mode: ExercisesMode, viewModel: ExerciseViewModel) {
        let viewController = ExerciseViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewController.mode = mode
        navigationController.pushViewController(viewController, animated: true)
    }
}
