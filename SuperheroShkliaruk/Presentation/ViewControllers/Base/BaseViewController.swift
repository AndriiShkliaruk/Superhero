//
//  BaseViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 16.03.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let viewModel = BaseViewModel()
    
//    override func loadView() {
//        super.loadView()
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: viewModel.characterImageName)
//        imageView.frame = view.bounds
//        imageView.contentMode = .scaleAspectFill
//        view.insertSubview(imageView, at: 0)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView()
        imageView.image = UIImage(named: viewModel.characterImageName)
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        view.insertSubview(imageView, at: 0)
    }

}
