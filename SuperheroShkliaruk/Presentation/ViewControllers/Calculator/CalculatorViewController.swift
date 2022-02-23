//
//  CalculatorViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class CalculatorViewController: UIViewController, Storyboarded {
    @IBOutlet weak var characterImageView: UIImageView!
    
    var coordinator: MainCoordinator?
    let viewModel = CalculatorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        characterImageView.image = UIImage(named: viewModel.characterImageName)
    }
}
