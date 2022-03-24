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
    private var profileViewModel: ProfileViewModel?
    var delegate: ProfileViewControllerDelegate?
    var imagePicker: ImagePicker?
    
    func setupUI(_ viewModel: ProfileViewModel) {
        profileViewModel = viewModel
        
        setupAvatarImage()
        nameLabel.textColor = .white
        nameLabel.text = viewModel.nameLabelText
        nameLabel.font = .helveticaNeueRegularWithSize18
        
        textFieldUnderlineView.backgroundColor = .white
        nameTextField.font = .helveticaNeueRegularWithSize18
        nameTextField.tintColor = .white
        nameTextField.configurePlaceholder(withText: viewModel.nameTextFieldPlaceholder, font: .helveticaNeueThinWithSize18, textColor: .customGray)
        nameTextField.autocapitalizationType = .sentences
        
        if !viewModel.name.isEmpty {
            nameTextField.text = viewModel.name
        }
    }
    
    private func setupAvatarImage() {
        if let imageData = profileViewModel?.avatarData {
            avatarImageButton.setImage(UIImage(data: imageData), for: .normal)
            setAvatarImageBorder()
        } else if let defaultImageName = profileViewModel?.defaultAvatarName {
            avatarImageButton.setImage(UIImage(named: defaultImageName), for: .normal)
        }
        avatarImageButton.imageView?.layer.cornerRadius = 8
        avatarImageButton.imageView?.contentMode = .scaleAspectFill
    }
    
    private func setAvatarImageBorder() {
        avatarImageButton.imageView?.layer.borderWidth = 1
        avatarImageButton.imageView?.layer.borderColor = UIColor.customDarkYellow.cgColor
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
        profileViewModel?.newName = sender.text ?? ""
        delegate?.updateSaveButtonState()
    }
    
    @IBAction private func avatarImageButtonTapped(_ sender: UIButton) {
        imagePicker?.present(from: sender)
    }
}

extension ProfileTableHeaderView: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let avatarImage = image else { return }
        avatarImageButton.setImage(avatarImage, for: .normal)
        if profileViewModel?.avatarData == nil {
            setAvatarImageBorder()
        }
        profileViewModel?.avatarData = avatarImage.pngData()
        profileViewModel?.isAvatarChanged = true
        delegate?.updateSaveButtonState()
    }
}
