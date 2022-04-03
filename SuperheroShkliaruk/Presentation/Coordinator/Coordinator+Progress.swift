//
//  Coordinator+Progress.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

extension MainCoordinator {
    func moveToProgress() {
        let viewController = ProgressViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToChart(with parameterViewModel: ParameterViewModel) {
        let viewController = ChartViewController.instantiate()
        viewController.viewModel = ChartViewModel(parameter: parameterViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
