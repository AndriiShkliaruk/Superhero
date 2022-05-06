//
//  MainTabBarController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 03.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    var coordinator: TabBarCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        tabBar.tintColor = .customYellow
        tabBar.barTintColor = .white
    }

}

