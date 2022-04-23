//
//  ProgramViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 18.04.2022.
//

import UIKit

class ProgramViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addExerciseButtonView: CustomRoundedButtonView!
    
    var coordinator: MainCoordinator?
    var viewModel: ProgramViewModel?
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let saveButton = UIBarButtonItem(title: viewModel?.saveBarButtonText, style: .plain, target: self, action: #selector(saveBarButtonTapped))
        saveButton.isEnabled = false
        return saveButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigationBar()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        addExerciseButtonView.setButtonTitle(viewModel?.addExerciseButtonText ?? "")
        addExerciseButtonView.setButtonActionOnTap { [weak self] in
            guard let self = self,
                  let viewModel = self.viewModel else { return }
            self.coordinator?.moveToMuscleGroups(with: self, viewModel: viewModel.generateMusclesViewModel())
        }
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ProgramExerciseCell.identifier, bundle: nil), forCellReuseIdentifier: ProgramExerciseCell.identifier)
        tableView.register(UINib(nibName: ProgramTableHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProgramTableHeader.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
    }
    
    private func setupNavigationBar() {
        title = viewModel?.navigationBarTitleText
        navigationItem.rightBarButtonItem = saveBarButtonItem
        navigationItem.backButtonTitle = viewModel?.backButtonText
    }
    
    @objc private func saveBarButtonTapped() {
        view.endEditing(true)
        
        guard let viewModel = viewModel else { return }
        viewModel.didSaveButtonTap() 
        coordinator?.backWithInfoView(iconName: viewModel.infoIconName, text: viewModel.infoText)
    }
}

extension ProgramViewController: UITableViewDelegate, UITableViewDataSource {    
    //MARK: - Table View Header Setup
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProgramTableHeader.identifier) as! ProgramTableHeader
        headerView.delegate = self
        guard let viewModel = viewModel else {
            return nil
        }
        headerView.configure(with: viewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 257
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.program.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProgramExerciseCell.identifier, for: indexPath) as! ProgramExerciseCell
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        let exerciseViewModel = viewModel.program.exercises[indexPath.row]
        cell.configure(with: exerciseViewModel)
        cell.coordinator = coordinator
        return cell
    }
}

extension ProgramViewController: ProgramViewControllerDelegate {
    func didNameChange(_ text: String) {
        viewModel?.changeName(text)
        saveBarButtonItem.isEnabled = viewModel?.isSaveButtonEnabled ?? true
    }
    
    func didDescriptionChange(_ text: String) {
        viewModel?.changeDescription(text)
        saveBarButtonItem.isEnabled = viewModel?.isSaveButtonEnabled ?? true
    }
    
    func didExercisesChange(_ musclesViewModel: MusclesViewModel) {
        viewModel?.changeExercises(by: musclesViewModel)
        saveBarButtonItem.isEnabled = viewModel?.isSaveButtonEnabled ?? true
    }
}
