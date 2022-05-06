//
//  StartCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 04.05.2022.
//

import UIKit

class StartCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let parentCoordinator: AppCoordinator
    
    init(navigationController: UINavigationController, parentCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let startViewController = StartViewController.instantiate()
        startViewController.coordinator = self
        navigationController.pushViewController(startViewController, animated: false)
    }
    
    func moveToTabs() {
        parentCoordinator.moveToTabs()
    }
}
