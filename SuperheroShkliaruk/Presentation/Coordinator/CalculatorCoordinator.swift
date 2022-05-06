//
//  CalculatorCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 05.05.2022.
//

import UIKit

class CalculatorCoordinator: BaseCoordinator, Coordinator {
    func start() {
        let viewController = CalculatorViewController.instantiate()
        viewController.coordinator = self
        pushViewController(viewController, animated: false)
    }
    
    func moveToBodyCalculator(_ mode: CalculatorMode) {
        let viewController = CalculatorModeViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = CalculatorModeViewModel(mode: mode)
        pushViewController(viewController, animated: true)
    }
    
    func presentRateActivities(configuration: (ActivityLevelViewController) -> Void) {
        let viewController = ActivityLevelViewController.instantiate()
        configuration(viewController)
        pushViewController(viewController, animated: true)
    }
}
