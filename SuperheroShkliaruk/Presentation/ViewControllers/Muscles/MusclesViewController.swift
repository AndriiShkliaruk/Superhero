//
//  MusclesViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class MusclesViewController: BaseViewController, Storyboarded {
    var coordinator: MainCoordinator?
    let viewModel = MusclesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
    }
}
