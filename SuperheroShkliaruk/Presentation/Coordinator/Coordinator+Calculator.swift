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
    
    func moveToCalculatorType(_ mode: CalculatorType) {
        let viewController = CalculatorTypeViewController.instantiate()
        viewController.coordinator = self
        viewController.viewModel = CalculatorTypeViewModel(mode: mode)
        navigationController.pushViewController(viewController, animated: true)
    }
}
