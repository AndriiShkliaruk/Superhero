//
//  ProgressViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProgressViewController: BaseViewController, Storyboarded {
    @IBOutlet private weak var menuTableView: UITableView!
    
    var coordinator: MainCoordinator?
    let viewModel = ProgressViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: MenuTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MenuTableViewCell.identifier)
        
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        menuTableView.backgroundColor = .clear
        
        if viewModel.parametersViewModels.isEmpty {
            showEmptyParametersInfoView()
        }
    }
    
    private func showEmptyParametersInfoView() {
        guard let icon = UIImage(named: viewModel.infoIconName) else { return }
        let infoView: InfoView = InfoView.fromNib()
        infoView.frame = view.frame
        infoView.configure(with: icon, text: viewModel.infoText, backgroundColor: .clear)
        view.addSubview(infoView)
    }
}

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parametersViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.parametersViewModels[indexPath.row].title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.moveToChart(with: viewModel.parametersViewModels[indexPath.row])
    }
}
