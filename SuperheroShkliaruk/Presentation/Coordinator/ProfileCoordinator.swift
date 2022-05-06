//
//  ProfileCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 04.05.2022.
//

import UIKit

class ProfileCoordinator: BaseCoordinator, Coordinator {    
    var parentCoordinator: TabBarCoordinator?

    func start() {
        let viewController = ProfileViewController.instantiate()
        viewController.coordinator = self
        pushViewController(viewController, animated: false)
    }
    
    func presentBodyParameters(configuration: (ParametersViewController) -> Void) {
        let viewController = ParametersViewController.instantiate()
        configuration(viewController)
        navigationController.present(viewController, animated: true)
    }
    
    func moveToHomeWithInfoView(iconName: String, text: String) {
        showInfoView(iconName: iconName, text: text) { [weak self] in
            self?.parentCoordinator?.selectTab(.home)
        }
    }
}
