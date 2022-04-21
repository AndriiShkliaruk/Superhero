//
//  Coordinator+Programs.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

extension MainCoordinator {
    func moveToPrograms() {
        let viewController = ProgramsViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToProgram(with mode: ProgramMode) {
        let viewController = ProgramViewController.instantiate()
        viewController.coordinator = self
        switch mode {
        case .create:
            viewController.viewModel = ProgramViewModel(mode: .create)
        case .edit(let program):
            viewController.viewModel = ProgramViewModel(mode: .edit(inputProgram: program))
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToMuscleGroups(with delegate: ProgramViewControllerDelegate, viewModel: MusclesViewModel) {
        let viewController = MusclesViewController.instantiate()
        viewController.mode = .edit
        viewController.coordinator = self
        viewController.viewModel = viewModel
        viewController.delegate = delegate
        navigationController.pushViewController(viewController, animated: true)
    }
}
