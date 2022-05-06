//
//  HomeViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.02.2022.
//

import UIKit

class HomeViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var characterLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var parametersTableView: UITableView!
    @IBOutlet private weak var bottomGradientView: UIView!
    
    private let viewModel = HomeViewModel()
    var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupParametersTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNameLabelText()
        updateAvatarImageView()
        viewModel.updateParametersViewModels()
        updateParametersTableView()
    }
    
    private func setupUI() {
        characterLabel.font = .sairaRegularWithSize24
        characterLabel.tintColor = .white
        characterLabel.text = viewModel.characterLabel
        
        nameLabel.font = .helveticaNeueRegularWithSize20
        nameLabel.tintColor = .customDarkYellow
        
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.customDarkYellow.cgColor
        
        bottomGradientView.backgroundColor = .clear
        bottomGradientView.applyBlackTopGradient()
    }
    
    private func setupParametersTableView() {
        parametersTableView.backgroundColor = .clear
        parametersTableView.dataSource = self
        parametersTableView.register(UINib(nibName: HomeParameterCell.identifier, bundle: nil), forCellReuseIdentifier: HomeParameterCell.identifier)
        parametersTableView.rowHeight = 132
        parametersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    private func updateNameLabelText() {
        if !viewModel.name.isEmpty {
            nameLabel.isHidden = false
            nameLabel.text = viewModel.name
        } else {
            nameLabel.isHidden = true
        }
    }
    
    private func updateAvatarImageView() {
        if let imageData = viewModel.avatarImageData {
            avatarImageView.image = UIImage(data: imageData)
            avatarImageView.isHidden = false
        } else {
            avatarImageView.isHidden = true
        }
    }
    
    private func updateParametersTableView() {
        parametersTableView.reloadData()
    }
}

//MARK: - ParametersTableView

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parametersViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeParameterCell.identifier, for: indexPath) as? HomeParameterCell else { return UITableViewCell() }
        cell.configure(with: viewModel.parametersViewModels[indexPath.row], coordinator: coordinator)
        return cell
    }
}
