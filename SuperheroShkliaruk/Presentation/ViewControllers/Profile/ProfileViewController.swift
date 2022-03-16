//
//  ProfileViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addParametersButton: CustomRoundedButton!
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let saveButton = UIBarButtonItem(title: viewModel.saveBarButtonText, style: .plain, target: self, action: #selector(saveBarButtonTapped))
        saveButton.isEnabled = false
        return saveButton
    }()
    
    var coordinator: MainCoordinator?
    private var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ProfileTableHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.identifier)
        tableView.register(UINib(nibName: ProfileTableFooterView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableFooterView.identifier)
        tableView.backgroundColor = .clear
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        characterImageView.image = UIImage(named: viewModel.characterImageName)
        
        addParametersButton.setTitle(viewModel.addParametersButtonText.capitalized, for: .normal)
        addParametersButton.backgroundColor = .customYellow
        addParametersButton.titleLabel?.font = .sairaRegularWithSize16
    }
    
    private func setupNavigationBar() {
        coordinator?.navigationController.navigationBar.tintColor = .customYellow
        navigationItem.rightBarButtonItem = saveBarButtonItem
        saveBarButtonItem.isEnabled = false
    }
    
    @objc private func saveBarButtonTapped() {
        viewModel.saveUserProfile()
        coordinator?.back()
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    //MARK: - Table View Header Setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderView.identifier) as! ProfileTableHeaderView
        headerView.profileViewModel = viewModel
        headerView.delegate = self
        return headerView
    }
    
    
    //MARK: - Table View Footer Setup
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableFooterView.identifier) as! ProfileTableFooterView
        
        footerView.descriptionLabel.text = viewModel.descriptionLabelText
        footerView.descriptionLabel.font = .sairaLightWithSize16
        footerView.descriptionLabel.textColor = .customGray
        
        return footerView
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ProfileViewController: ProfileTableHeaderViewDelegate {
    func setIsEnabledSaveButton(_ isEnabled: Bool) {
        saveBarButtonItem.isEnabled = isEnabled
    }
    
    func setProfileName(_ name: String) {
        viewModel.profileNewName = name
    }
}

