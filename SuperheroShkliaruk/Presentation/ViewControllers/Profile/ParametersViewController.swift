//
//  ParametersViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 21.03.2022.
//

import UIKit

class ParametersViewController: UIViewController, Storyboarded {
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
        tableView.register(UINib(nibName: ProfileParametersListCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileParametersListCell.identifier)
        
        topLabel.font = .sairaMediumWithSize18
        topLabel.textColor = .customDarkYellow
        topLabel.text = viewModel?.topLabelText
        
        cancelButton.titleLabel?.font = .sairaRegularWithSize18
        cancelButton.titleLabel?.textColor = .white
        cancelButton.setTitle(viewModel?.cancelButtonText, for: .normal)
        
        selectButton.titleLabel?.font = .sairaRegularWithSize18
        selectButton.titleLabel?.textColor = .customDarkYellow
        selectButton.setTitle(viewModel?.selectButtonText, for: .normal)
    }
    

    @IBAction private func cancelButtonTapped(_ sender: UIButton) {
        delegate?.reset()
    }
    
    @IBAction private func selectButtonTapped(_ sender: UIButton) {
        delegate?.save()
    }
}

extension ParametersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileParametersListCell.identifier, for: indexPath) as? ProfileParametersListCell else { return UITableViewCell() }
        if let parametersList = viewModel?.userProfile.parameters {
            cell.configure(with: parametersList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userProfile.parameters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.userProfile.parameters[indexPath.row].toggleCheckbox()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
