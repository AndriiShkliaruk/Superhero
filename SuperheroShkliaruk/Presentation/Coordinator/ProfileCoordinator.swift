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
    
    func finishWithInfoView(iconName: String, text: String, nextTab tab: TabBarItem) {
        if let navigationControllerView = navigationController.view,
           let icon = UIImage(named: iconName) {
            
            let infoView: InfoView = InfoView.fromNib()
            infoView.frame = navigationControllerView.frame
            infoView.configure(with: icon,
                               text: text,
                               backgroundColor: nil)
            UIView.showWithTransition(for: 2, childView: infoView, in: navigationControllerView) { [weak self] in
                self?.parentCoordinator?.selectTab(tab)
            }
        } else {
            parentCoordinator?.selectTab(tab)
        }
    }
    
    func finish() {
        parentCoordinator?.selectTab(.home)
    }
}
