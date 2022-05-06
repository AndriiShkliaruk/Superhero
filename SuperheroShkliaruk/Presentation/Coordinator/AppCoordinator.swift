//
//  AppCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 03.05.2022.
//

import UIKit

class AppCoordinator: Coordinator, NavigationCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        ProfileManager.sharedInstance.retrieveSavedProfile()
        if ProfileManager.sharedInstance.userProfile != nil {
            moveToTabs()
        } else {
            showStart()
        }
    }
    
    func showStart() {
        let startCoordinator = StartCoordinator(navigationController: navigationController, parentCoordinator: self)
        startCoordinator.start()
    }
    
    func moveToTabs() {
        let tabCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabCoordinator.start()
    }
}
