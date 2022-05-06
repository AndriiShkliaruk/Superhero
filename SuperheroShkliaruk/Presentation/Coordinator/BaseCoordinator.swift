//
//  BaseCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 04.05.2022.
//

import UIKit

class BaseCoordinator: NavigationCoordinator {
    var navigationController: UINavigationController
    
    init() {
        navigationController = UINavigationController()
    }
    
    var navigationViewController: UIViewController {
        navigationController
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func backWithInfoView(iconName: String, text: String) {
        if let navigationControllerView = navigationController.view,
           let icon = UIImage(named: iconName) {
            
            let infoView: InfoView = InfoView.fromNib()
            infoView.frame = navigationControllerView.frame
            infoView.configure(with: icon,
                               text: text,
                               backgroundColor: nil)
            UIView.showWithTransition(for: 2, childView: infoView, in: navigationControllerView) { [weak self] in
                self?.back()
            }
        } else {
            back()
        }
    }
    
    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = navigationController.viewControllers.count == 1
        navigationController.pushViewController(viewController, animated: animated)
    }
}
