//
//  ProfileViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProfileViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addParametersButtonView: CustomRoundedButtonView!
    
    var coordinator: MainCoordinator?
    private var viewModel = ProfileViewModel()
    private var activeTableViewCell: UITableViewCell?
    
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
        
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ProfileParametersCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileParametersCell.identifier)
        tableView.register(UINib(nibName: ProfileTableHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableHeader.identifier)
        tableView.register(UINib(nibName: ProfileTableFooter.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProfileTableFooter.identifier)
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        addParametersButtonView.setButtonTitle(viewModel.addParametersButtonText)
        addParametersButtonView.setButtonActionOnTap(addParametersButtonTapped)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc private func saveBarButtonTapped() {
        view.endEditing(true)
        viewModel.didSaveButtonTap()
        coordinator?.backWithInfoView(iconName: viewModel.infoIconName, text: viewModel.infoText)
    }
    
    private func addParametersButtonTapped() {
        coordinator?.presentBodyParameters { viewController in
            viewController.delegate = self
            viewController.viewModel = viewModel
            viewController.transitioningDelegate = transitionDelegate
            viewController.modalPresentationStyle = .custom
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let cell = activeTableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.selectedParameters.count
    }
    
    //MARK: - Table View Header Setup
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableHeader.identifier) as! ProfileTableHeader
        headerView.configure(with: viewModel)
        headerView.delegate = self
        headerView.imagePicker = ImagePicker(presentationController: self, delegate: headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 295
    }
    
    //MARK: - Table View Footer Setup
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileTableFooter.identifier) as! ProfileTableFooter
        footerView.configure(with: viewModel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 112
    }
    
    //MARK: - Table View Cell Setup
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileParametersCell.identifier, for: indexPath) as? ProfileParametersCell else { return UITableViewCell() }
        let parameterViewModel = viewModel.selectedParameters[indexPath.row]
        cell.configure(with: parameterViewModel, textFieldTag: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let parameter = viewModel.selectedParameters[indexPath.row]
        viewModel.deleteDisplayedParameter(parameter)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
        updateSaveButtonState()
    }
}

extension ProfileViewController: ProfileViewControllerDelegate {
    func didNameChange(_ text: String) {
        viewModel.changeName(text)
        updateSaveButtonState()
    }
    
    func didAvatarChange(_ imageData: Data?) {
        viewModel.changeAvatar(imageData)
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        saveBarButtonItem.isEnabled = viewModel.isSaveButtonEnabled
    }
    
    func didActiveCellChange(_ cell: UITableViewCell?) {
        activeTableViewCell = cell
    }
}

extension ProfileViewController: BodyParametersDelegate {
    func didTapResetParametersList() {
        viewModel.resetParametersCheckboxes()
        coordinator?.dismiss(animated: true)
    }
    
    func didTapSaveParametersList() {
        viewModel.updateParametersStates()
        coordinator?.dismiss(animated: true)
        tableView.reloadData()
        updateSaveButtonState()
    }
}
