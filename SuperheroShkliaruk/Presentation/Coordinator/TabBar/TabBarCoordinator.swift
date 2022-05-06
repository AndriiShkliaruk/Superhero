//
//  TabBarCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 03.05.2022.
//

import UIKit

class TabBarCoordinator: Coordinator, NavigationCoordinator {
    var navigationController: UINavigationController
    private let tabBarController = MainTabBarController()
    
    let homeCoordinator = HomeCoordinator()
    let profileCoordinator = ProfileCoordinator()
    let programsCoordinator = ProgramsCoordinator()
    let musclesCoordinator = MusclesCoordinator(UINavigationController())
    let calculatorCoordinator = CalculatorCoordinator()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        tabBarController.coordinator = self
        configureChildCoordinators()
        
        let homeViewController = homeCoordinator.navigationViewController
        homeViewController.tabBarItem = generateTabBarItem(.home)
        
        let profileViewController = profileCoordinator.navigationViewController
        profileViewController.tabBarItem = generateTabBarItem(.profile)
        
        let programsViewController = programsCoordinator.navigationViewController
        programsViewController.tabBarItem = generateTabBarItem(.programs)
        
        let musclesViewController = musclesCoordinator.navigationViewController
        musclesViewController.tabBarItem = generateTabBarItem(.muscles)
        
        let calculatorViewController = calculatorCoordinator.navigationViewController
        calculatorViewController.tabBarItem = generateTabBarItem(.calculator)
        
        tabBarController.viewControllers = [homeViewController, profileViewController, programsViewController, musclesViewController, calculatorViewController]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func configureChildCoordinators() {
        homeCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileCoordinator.start()
        
        programsCoordinator.start()
        
        musclesCoordinator.parentCoordinator = self
        musclesCoordinator.start()
        
        calculatorCoordinator.start()
    }
    
    func selectTab(_ tab: TabBarItem) {
        tabBarController.selectedIndex = tab.index
    }
    
    private func generateTabBarItem(_ item: TabBarItem) -> UITabBarItem {
        return UITabBarItem(title: item.description, image: item.icon, selectedImage: item.selectedIcon)
    }
}
