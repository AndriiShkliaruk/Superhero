//
//  HomeViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    
    let viewModel = HomeViewModel()
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        characterImageView.image = UIImage(named: viewModel.characterImageName)
        
        characterLabel.font = .sairaRegularWithSize24
        characterLabel.tintColor = .white
        characterLabel.text = viewModel.characterLabelText
        
    }
    

}
