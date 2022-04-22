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
    
    func moveToExercise(with viewModel: ExerciseViewModel) {
        let viewController = ExerciseViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
