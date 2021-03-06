//
//  Coordinator+Profile.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

extension MainCoordinator {
    func moveToProfile() {
        let viewController = ProfileViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentBodyParameters(configuration: (ParametersViewController) -> Void) {
        let viewController = ParametersViewController.instantiate()
        configuration(viewController)
        navigationController.present(viewController, animated: true)
    }
}
