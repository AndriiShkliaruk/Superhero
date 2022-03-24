//
//  ProfileViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProfileViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var buttonBackgroundView: UIView!
    @IBOutlet private weak var addParametersButton: CustomRoundedButton!
    
    private var viewModel = ProfileViewModel()
    var coordinator: MainCoordinator?
    private lazy var transitionDelegate = DimmTransitionManager()
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let saveButton = UIBarButtonItem(title: viewModel.saveBarButtonText, style: .plain, target: self, action: #selector(saveBarButtonTapped))
        saveButton.isEnabled = false
        return saveButton
    }()
    
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        buttonBackgroundView.applyBlackTopGradient()
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
    
    @IBAction private func addParametersButtonTapped(_ sender: UIButton) {
        coordinator?.presentBodyParameters { viewController in
            viewController.delegate = self
            viewController.viewModel = viewModel
            viewController.transitioningDelegate = transitionDelegate
            viewController.modalPresentationStyle = .custom
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table View Header Setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeaderView.identifier) as! ProfileTableHeaderView
        headerView.setupUI(viewModel)
        headerView.delegate = self
        headerView.imagePicker = ImagePicker(presentationController: self, delegate: headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 293
    }
    
    
    //MARK: - Table View Footer Setup
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableFooterView.identifier) as! ProfileTableFooterView
        footerView.setupUI(viewModel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.selectedParameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileParametersCell.identifier, for: indexPath) as? ProfileParametersCell else { return UITableViewCell() }
        let parameterViewModel = viewModel.selectedParameters[indexPath.row]
        parameterViewModel.delegate = self
        cell.configure(with: parameterViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let parameter = viewModel.selectedParameters[indexPath.row]
        viewModel.deleteDisplayedParameter(parameter)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension ProfileViewController: ProfileViewControllerDelegate {
    func updateSaveButtonState() {
        saveBarButtonItem.isEnabled = viewModel.stateHasChanges()
    }
}

extension ProfileViewController: BodyParametersDelegate {
    func reset() {
        viewModel.resetParametersCheckboxes()
        coordinator?.dismiss(animated: true)
    }
    
    func save() {
        viewModel.updateParametersStates()
        coordinator?.dismiss(animated: true)
        tableView.reloadData()
    }
}
