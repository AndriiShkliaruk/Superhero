//
//  Coordinator.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 15.02.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
