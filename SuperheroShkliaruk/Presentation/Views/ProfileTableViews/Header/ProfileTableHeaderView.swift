//
//  ProfileTableHeaderView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 14.03.2022.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var avatarImageButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var textFieldUnderlineView: UIView!
    
    static let identifier = "ProfileTableHeaderView"
    var delegate: ProfileViewControllerDelegate?
    private var profileViewModel: ProfileViewModel?
    
    func setupUI(_ viewModel: ProfileViewModel) {
        profileViewModel = viewModel
        
        
        
        nameLabel.textColor = .white
        nameLabel.text = viewModel.nameLabelText
        nameLabel.font = .helveticaNeueRegularWithSize18
        
        textFieldUnderlineView.backgroundColor = .white
        nameTextField.font = .helveticaNeueRegularWithSize18
        nameTextField.tintColor = .white
        nameTextField.configurePlaceholder(withText: viewModel.nameTextFieldPlaceholder, font: .helveticaNeueThinWithSize18, textColor: .customGray)
        nameTextField.autocapitalizationType = .sentences
        
        if !viewModel.profileName.isEmpty {
            nameTextField.text = viewModel.profileName
        }
    }
    
    @IBAction private func nameTextFieldEditingDidBegin(_ sender: UITextField) {
        textFieldUnderlineView.backgroundColor = .customDarkYellow
    }
    
    @IBAction private func nameTextFieldEditingDidEnd(_ sender: UITextField) {
        sender.updateUnderlineColor(underlineView: textFieldUnderlineView)
    }
    
    @IBAction private func nameTextFieldDidEndOnExit(_ sender: UITextField) {
        sender.updateUnderlineColor(underlineView: textFieldUnderlineView)
        sender.resignFirstResponder()
    }
    
    @IBAction private func nameTextFieldEditingChanged(_ sender: UITextField) {
        profileViewModel?.newProfileName = sender.text ?? ""
        delegate?.updateSaveButtonState()
    }
    
    @IBAction private func avatarImageButtonTapped(_ sender: UIButton) {
        
    }
}
