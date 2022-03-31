//
//  ChartViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 31.03.2022.
//

import UIKit

class ChartViewController: UIViewController, Storyboarded {
    var viewModel: ParameterViewModel?
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() {
        title = viewModel?.chartTitle
    }
}
