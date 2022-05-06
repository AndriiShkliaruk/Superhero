//
//  ProgressCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 05.05.2022.
//

import UIKit

class ProgressCoordinator: BaseCoordinator, Coordinator {
    func start() {
        let viewController = ProgressViewController.instantiate()
        viewController.coordinator = self
        pushViewController(viewController, animated: false)
    }
    
    func moveToChart(with parameterViewModel: ParameterViewModel) {
        let viewController = ChartViewController.instantiate()
        viewController.viewModel = ChartViewModel(parameter: parameterViewModel)
        pushViewController(viewController, animated: true)
    }
}
