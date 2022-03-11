//
//  ProfileViewController.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, Storyboarded {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addParametersButton: CustomRoundedButton!
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: viewModel.saveBarButtonText, style: .plain, target: self, action: #selector(saveBarButtonTapped))
    }()
    
    var coordinator: MainCoordinator?
    let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        title = viewModel.navigationBarTitleText
        characterImageView.image = UIImage(named: viewModel.characterImageName)
        
        nameLabel.text = viewModel.nameLabelText
        nameLabel.font = .helveticaNeueRegularWithSize18
        nameLabel.tintColor = .white
        
        nameTextField.font = .helveticaNeueRegularWithSize18
        nameTextField.tintColor = .white
        nameTextField.configurePlaceholder(withText: viewModel.nameTextFieldPlaceholder, font: .helveticaNeueThinWithSize18, textColor: .customGray)
        nameTextField.underlined(withColor: .white)
        nameTextField.delegate = self
        
        descriptionLabel.text = viewModel.descriptionLabelText
        descriptionLabel.font = .sairaLightWithSize16
        descriptionLabel.textColor = .customGray
        
        addParametersButton.setTitle(viewModel.addParametersButtonText.capitalized, for: .normal)
        addParametersButton.backgroundColor = .customYellow
        addParametersButton.titleLabel?.font = .sairaRegularWithSize16
    }
    
    private func setupNavigationBar() {
        coordinator?.navigationController.navigationBar.tintColor = .customYellow
        navigationItem.rightBarButtonItem = saveBarButtonItem
        saveBarButtonItem.isEnabled = false
    }
    @IBAction func nameTextFieldEditingDidBegin(_ sender: UITextField) {
        sender.changeUnderlineColor(.customYellow)
    }
    
    @IBAction func nameTextFieldEditingDidEnd(_ sender: UITextField) {
        if !(sender.text?.isEmpty ?? true) {
            sender.changeUnderlineColor(.customYellow)
        } else {
            sender.changeUnderlineColor(.white)
        }
    }
    
    @objc private func saveBarButtonTapped() {
        
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
