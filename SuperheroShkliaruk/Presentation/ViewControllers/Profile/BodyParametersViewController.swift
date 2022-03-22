//
//  BodyParametersViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 21.03.2022.
//

import UIKit

class BodyParametersViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var selectButton: UIButton!
    
    var delegate: BodyParametersDelegate?
    var viewModel: ProfileViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        innerView.backgroundColor = .black
        innerView.layer.cornerRadius = 8
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.white.cgColor
        
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BodyParameterListCell.identifier, bundle: nil), forCellReuseIdentifier: BodyParameterListCell.identifier)
    }
    

    @IBAction private func cancelButtonTapped(_ sender: UIButton) {
        delegate?.reset()
    }
    
    @IBAction private func selectButtonTapped(_ sender: UIButton) {
        delegate?.save()
    }
}

extension BodyParametersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BodyParameterListCell.identifier, for: indexPath) as? BodyParameterListCell else { return UITableViewCell() }
        if let parametersList = viewModel?.parametersViewModels {
            cell.configure(with: parametersList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.parametersViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.parametersViewModels[indexPath.row].toggleCheckbox()
        tableView.reloadData()
    }
}
