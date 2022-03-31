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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.textColor = .white
        nameLabel.font = .helveticaNeueRegularWithSize18
        textFieldUnderlineView.backgroundColor = .white
        nameTextField.font = .helveticaNeueRegularWithSize18
        nameTextField.tintColor = .white
        nameTextField.autocapitalizationType = .sentences
        avatarImageButton.imageView?.layer.cornerRadius = 8
        avatarImageButton.imageView?.contentMode = .scaleAspectFill
        avatarImageButton.imageView?.layer.borderColor = UIColor.customDarkYellow.cgColor
    }
    
    func configure(with viewModel: ProfileViewModel) {
        profileViewModel = viewModel
        updateAvatarImage()
        nameLabel.text = viewModel.nameLabelText
        nameTextField.configurePlaceholder(withText: viewModel.nameTextFieldPlaceholder, font: .helveticaNeueThinWithSize18, textColor: .customGray)
        nameTextField.text = viewModel.userProfile.name
    }
    
    private func updateAvatarImage() {
        if let imageData = profileViewModel?.userProfile.avatar {
            avatarImageButton.setImage(UIImage(data: imageData), for: .normal)
            avatarImageButton.imageView?.layer.borderWidth = 1
        } else if let defaultImageName = profileViewModel?.defaultAvatarName {
            avatarImageButton.setImage(UIImage(named: defaultImageName), for: .normal)
            avatarImageButton.imageView?.layer.borderWidth = 0
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
        profileViewModel?.userProfile.name = sender.text ?? ""
        delegate?.updateSaveButtonState()
    }
    
    @IBAction private func avatarImageButtonTapped(_ sender: UIButton) {
        let isDeletable = profileViewModel?.userProfile.avatar != nil ? true : false
        imagePicker?.present(from: sender, isDeletable: isDeletable)
    }
}

extension ProfileTableHeaderView: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let avatarImage = image else { return }
        profileViewModel?.userProfile.avatar = avatarImage.pngData()
        updateAvatarImage()
        delegate?.updateSaveButtonState()
    }
    
    func deleteImage() {
        profileViewModel?.userProfile.avatar = nil
        updateAvatarImage()
        delegate?.updateSaveButtonState()
    }
}
