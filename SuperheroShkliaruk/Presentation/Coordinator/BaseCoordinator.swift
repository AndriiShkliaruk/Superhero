//
//  BaseCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 04.05.2022.
//

import UIKit

class BaseCoordinator: NavigationCoordinator {
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init() {
        self.init(UINavigationController())
    }
    
    var navigationViewController: UIViewController {
        navigationController
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func backWithInfoView(iconName: String, text: String) {
        showInfoView(iconName: iconName, text: text, completion: back)
    }
    
    func showInfoView(iconName: String, text: String, completion: @escaping () -> Void) {
        if let navigationControllerView = navigationController.view,
           let icon = UIImage(named: iconName) {
            
            let infoView: InfoView = InfoView.fromNib()
            infoView.frame = navigationControllerView.frame
            infoView.configure(with: icon,
                               text: text,
                               backgroundColor: nil)
            UIView.showWithTransition(for: 2, childView: infoView, in: navigationControllerView) {
                completion()
            }
        } else {
            completion()
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
