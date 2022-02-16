//
//  MainCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 15.02.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = StartViewController.instantiate()
        navigationController.pushViewController(startViewController, animated: false)
    }
    
    
}
