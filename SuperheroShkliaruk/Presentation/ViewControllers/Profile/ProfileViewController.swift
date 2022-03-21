//
//  ProfileViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProfileViewController: BaseViewController, Storyboarded {
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
        tableView.register(UINib(nibName: ProfileParametersCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileParametersCell.identifier)
        tableView.register(UINib(nibName: ProfileTableHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableHeaderView.identifier)
        tableView.register(UINib(nibName: ProfileTableFooterView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableFooterView.identifier)
        tableView.backgroundColor = .clear
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        
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
    
    @IBAction func addParametersButtonTapped(_ sender: UIButton) {
        let parametersListView: BodyParametersListView = UIView.fromNib()
        parametersListView.viewModel = viewModel
        parametersListView.delegate = self
        parametersListView.frame = view.frame
        UIView.showWithTransition(childView: parametersListView, in: view)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table View Header Setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderView.identifier) as! ProfileTableHeaderView
        headerView.setupUI(viewModel)
        headerView.delegate = self
        return headerView
    }
    
    
    //MARK: - Table View Footer Setup
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableFooterView.identifier) as! ProfileTableFooterView
        footerView.setupUI(viewModel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayedParameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileParametersCell.identifier, for: indexPath) as? ProfileParametersCell else { return UITableViewCell() }
        cell.configure(with: viewModel.displayedParameters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let parameter = viewModel.displayedParameters[indexPath.row]
        viewModel.deleteDisplayedParameter(parameter)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension ProfileViewController: ProfileTableHeaderViewDelegate {
    func setIsEnabledSaveButton(_ isEnabled: Bool) {
        saveBarButtonItem.isEnabled = isEnabled
    }
    
    func setProfileName(_ name: String) {
        viewModel.newProfileName = name
    }
}

extension ProfileViewController: BodyParametersListDelegate {
    func close(childView: UIView) {
        viewModel.resetParametersCheckboxes()
        UIView.hideWithTransition(childView: childView, from: view)
    }
    
    func saveAndClose(childView: UIView) {
        viewModel.updateParametersStates()
        UIView.hideWithTransition(childView: childView, from: view)
        tableView.reloadData()
    }
}
