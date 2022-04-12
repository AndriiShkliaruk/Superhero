//
//  MusclesViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

enum MusclesViewControllerMode {
    case normal, edit
}

class MusclesViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var tableView: UITableView!
    
    var mode: MusclesViewControllerMode = .normal
    var coordinator: MainCoordinator?
    let viewModel = MusclesViewModel()
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let saveButton = UIBarButtonItem(title: viewModel.saveBarButtonText, style: .plain, target: self, action: #selector(saveBarButtonTapped))
        return saveButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        title = viewModel.navigationBarTitleText
        
        guard mode == .edit else { return }
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ExerciseCell.identifier, bundle: nil), forCellReuseIdentifier: ExerciseCell.identifier)
        tableView.register(UINib(nibName: MusclesTableHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: MusclesTableHeaderView.identifier)
        tableView.backgroundColor = .clear
    }
    
    @objc private func saveBarButtonTapped() {
        
    }
}

extension MusclesViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table View Header Setup
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MusclesTableHeaderView.identifier) as! MusclesTableHeaderView
        headerView.configure(with: viewModel.muscleGroupViewModels[section])
        
        headerView.tapClosure = { [weak self] in
            guard let self = self else { return }
            
            var indexPaths = [IndexPath]()
            for row in self.viewModel.muscleGroupViewModels[section].exercises.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
            
            self.viewModel.muscleGroupViewModels[section].isOpen.toggle()
            
            if self.viewModel.muscleGroupViewModels[section].isOpen {
                tableView.insertRows(at: indexPaths, with: .fade)
            } else {
                tableView.deleteRows(at: indexPaths, with: .fade)
            }
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 53
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.muscleGroupViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupViewModel = viewModel.muscleGroupViewModels[section]
        return groupViewModel.isOpen ? groupViewModel.exercises.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.identifier, for: indexPath) as! ExerciseCell
        cell.configure(with: viewModel.muscleGroupViewModels[indexPath.section].exercises[indexPath.row], for: mode)
        
        if mode == .edit, let headerView = tableView.headerView(forSection: indexPath.section) as? MusclesTableHeaderView {
            cell.delegate = headerView
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
