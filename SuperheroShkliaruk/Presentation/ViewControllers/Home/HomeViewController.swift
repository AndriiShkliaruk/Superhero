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
    @IBOutlet private weak var parametersCollectionView: UICollectionView!
    @IBOutlet private weak var menuTableView: UITableView!
    
    private let viewModel = HomeViewModel()
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parametersCollectionView.delegate = self
        parametersCollectionView.dataSource = self
        parametersCollectionView.register(UINib(nibName: HomeParametersCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeParametersCell.identifier)
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: MenuTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MenuTableViewCell.identifier)
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.navigationController.setNavigationBarHidden(true, animated: animated)
        updateNameLabelText()
        updateAvatarImageView()
        
        viewModel.updateParametersViewModels()
        updateParametersCollectionView()
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
        
        parametersCollectionView.backgroundColor = .clear
        menuTableView.backgroundColor = .clear
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
    
    private func updateParametersCollectionView() {
        parametersCollectionView.reloadData()
    }
}

//MARK: - MenuTableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.tableItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.pushToViewController(at: indexPath, with: coordinator)
    }
}

//MARK: - ParametersCollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.parametersViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = parametersCollectionView.dequeueReusableCell(withReuseIdentifier: HomeParametersCell.identifier, for: indexPath) as? HomeParametersCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.parametersViewModels[indexPath.row])
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: HomeParametersCell = Bundle.main.loadNibNamed(HomeParametersCell.identifier, owner: self)?.first as? HomeParametersCell else {
            return CGSize.zero
        }
        
        cell.configure(with: viewModel.parametersViewModels[indexPath.row])
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 84)
    }
}
