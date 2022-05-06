//
//  NavigationCoordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 04.05.2022.
//

import UIKit

protocol NavigationCoordinator {
    var navigationController: UINavigationController { get set }
    init(_ navigationController: UINavigationController)
}
