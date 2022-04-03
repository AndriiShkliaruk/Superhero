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
        ProfileManager.sharedInstance.retrieveSavedProfile()
        if ProfileManager.sharedInstance.userProfile != nil {
            moveToHome()
        } else {
            let startViewController = StartViewController.instantiate()
            startViewController.coordinator = self
            navigationController.pushViewController(startViewController, animated: false)
        }
    }
    
    func moveToHome() {
        let homeViewController = HomeViewController.instantiate()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
}
