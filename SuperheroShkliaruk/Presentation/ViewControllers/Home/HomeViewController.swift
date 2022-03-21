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
    @IBOutlet private weak var menuTableView: UITableView!
    
    let viewModel = HomeViewModel()
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: MenuTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MenuTableViewCell.identifier)
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.navigationController.setNavigationBarHidden(true, animated: animated)
        updateNameLabelText()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.navigationController.setNavigationBarHidden(false, animated: animated)
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
        avatarImageView.isHidden = true
        
        menuTableView.backgroundColor = .clear
    }
    
    private func updateNameLabelText() {
        if !viewModel.profileName.isEmpty {
            nameLabel.isHidden = false
            nameLabel.text = viewModel.profileName
        } else {
            nameLabel.isHidden = true
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.pushToViewController(at: indexPath, with: coordinator)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.tableItems[indexPath.row])
        
        return cell
    }
}
