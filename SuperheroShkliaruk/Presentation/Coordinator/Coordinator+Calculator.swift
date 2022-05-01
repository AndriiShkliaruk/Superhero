//
//  Coordinator+Calculator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

extension MainCoordinator {
    func moveToCalculator() {
        let viewController = CalculatorViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func moveToBodyCalculator(_ mode: CalculatorMode) {
        let viewController = CalculatorModeViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = CalculatorModeViewModel(mode: mode)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentRateActivities(configuration: (ActivityLevelViewController) -> Void) {
        let viewController = ActivityLevelViewController.instantiate()
        configuration(viewController)
        navigationController.present(viewController, animated: true)
    }
}
