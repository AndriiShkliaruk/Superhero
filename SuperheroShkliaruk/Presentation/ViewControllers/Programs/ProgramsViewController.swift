//
//  ProgramsViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProgramsViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var programsTableView: UITableView!
    @IBOutlet private weak var newProgramButtonView: CustomRoundedButtonView!
    
    var coordinator: MainCoordinator?
    private var viewModel = ProgramsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupProgramsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateProgramViewModels()
        programsTableView.reloadData()
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        titleLabel.font = .sairaRegularWithSize24
        titleLabel.textColor = .white
        newProgramButtonView.setButtonTitle(viewModel.newProgramButtonText)
        newProgramButtonView.setButtonActionOnTap(newProgramButtonTapped)
    }
    
    private func setupProgramsTableView() {
        programsTableView.backgroundColor = .clear
        programsTableView.delegate = self
        programsTableView.dataSource = self
        programsTableView.register(UINib(nibName: ProgramCell.identifier, bundle: nil), forCellReuseIdentifier: ProgramCell.identifier)
        programsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
    }
    
    private func newProgramButtonTapped() {
        coordinator?.moveToProgram(with: .create)
    }
}

extension ProgramsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgramCell.identifier, for: indexPath) as? ProgramCell else { return UITableViewCell() }
        let programViewModel = viewModel.fetchProgramViewModels()[indexPath.row]
        cell.configure(with: programViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.moveToProgram(with: .edit(inputProgram: viewModel.programs[indexPath.row]))
    }
}
