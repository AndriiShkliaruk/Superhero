//
//  ProfileTableHeaderView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 14.03.2022.
//

import UIKit

protocol ProfileTableHeaderViewDelegate {
    func setProfileName(_ name: String)
    func setIsEnabledSaveButton(_ isEnabled: Bool)
}

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    
    static let identifier = "ProfileTableHeaderView"
    var delegate: ProfileTableHeaderViewDelegate?
    var viewModel: ProfileViewModel? {
        didSet {
            guard let profileViewModel = viewModel else { return }
            setupUI(profileViewModel)
        }
    }
    
    private func setupUI(_ viewModel: ProfileViewModel) {
        nameLabel.textColor = .white
        nameLabel.text = viewModel.nameLabelText
        nameLabel.font = .helveticaNeueRegularWithSize18
        
        nameTextField.underlined(withColor: .white)
        nameTextField.font = .helveticaNeueRegularWithSize18
        nameTextField.tintColor = .white
        nameTextField.configurePlaceholder(withText: viewModel.nameTextFieldPlaceholder, font: .helveticaNeueThinWithSize18, textColor: .customGray)
        nameTextField.autocapitalizationType = .sentences
        
        if !viewModel.profileName.isEmpty {
            nameTextField.text = viewModel.profileName
        }
        
        nameTextField.addTarget(self, action: #selector(nameTextFieldEditingDidBegin), for: .editingDidBegin)
        nameTextField.addTarget(self, action: #selector(nameTextFieldEditingDidEnd), for: .editingDidEnd)
        nameTextField.addTarget(self, action: #selector(nameTextFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        nameTextField.addTarget(self, action: #selector(nameTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc private func nameTextFieldEditingDidBegin(_ sender: UITextField) {
        sender.changeUnderlineColor(.customYellow)
    }
    
    @objc private func nameTextFieldEditingDidEnd(_ sender: UITextField) {
        updateTextFieldUnderlineColor(sender)
    }
    
    @objc private func nameTextFieldEditingDidEndOnExit(_ sender: UITextField) {
        updateTextFieldUnderlineColor(sender)
        sender.resignFirstResponder()
    }
    
    @objc private func nameTextFieldEditingChanged(_ sender: UITextField) {
        guard let enteredName = sender.text else { return }
        delegate?.setIsEnabledSaveButton(isValidNewEnteredName(enteredName))
        delegate?.setProfileName(enteredName)
    }
    
    private func updateTextFieldUnderlineColor(_ sender: UITextField) {
        if !(sender.text?.isEmpty ?? true) {
            sender.changeUnderlineColor(.customYellow)
        } else {
            sender.changeUnderlineColor(.white)
        }
    }
    
    private func isValidNewEnteredName(_ name: String?) -> Bool {
        guard let newName = name else { return false }
        return !newName.isEmpty && newName != viewModel?.profileName
    }
}
