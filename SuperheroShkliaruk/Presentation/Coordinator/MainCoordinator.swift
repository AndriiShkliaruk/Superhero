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
            home()
        } else {
            let startViewController = StartViewController.instantiate()
            startViewController.coordinator = self
            navigationController.pushViewController(startViewController, animated: false)
        }
    }
    
    func home() {
        let homeViewController = HomeViewController.instantiate()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    
}
