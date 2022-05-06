//
//  HomeCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 04.05.2022.
//

import UIKit

class HomeCoordinator: BaseCoordinator, Coordinator {
    func start() {
        let viewController = HomeViewController.instantiate()
        viewController.coordinator = self
        pushViewController(viewController, animated: false)
    }
}
