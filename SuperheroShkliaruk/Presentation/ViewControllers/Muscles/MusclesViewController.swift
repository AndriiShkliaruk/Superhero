//
//  MusclesViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class MusclesViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var characterImageView: UIImageView!
    
    var coordinator: MainCoordinator?
    let viewModel = MusclesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        characterImageView.image = UIImage(named: viewModel.characterImageName)
    }
}
