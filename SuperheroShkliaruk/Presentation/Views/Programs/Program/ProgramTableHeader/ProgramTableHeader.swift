//
//  ProgramTableHeader.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 18.04.2022.
//

import UIKit

class ProgramTableHeader: UITableViewHeaderFooterView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nameUnderlineView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var descriptionUnderlineView: UIView!
    
    static let identifier = "ProgramTableHeader"
    var delegate: ProgramViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.font = .sairaMediumWithSize24
        titleLabel.textColor = .white
        
        nameLabel.font = .helveticaNeueRegularWithSize18
        nameLabel.textColor = .white
        nameTextField.font = .helveticaNeueRegularWithSize18
        nameTextField.textColor = .white
        nameTextField.tintColor = .white
        nameUnderlineView.backgroundColor = .white
        
        descriptionLabel.font = .helveticaNeueRegularWithSize18
        descriptionLabel.textColor = .white
        descriptionTextField.font = .helveticaNeueRegularWithSize18
        descriptionTextField.textColor = .white
        descriptionTextField.tintColor = .white
        descriptionUnderlineView.backgroundColor = .white
    }
    
    func configure(with viewModel: ProgramViewModel) {
        titleLabel.text = viewModel.titleLabelText
        nameLabel.text = viewModel.nameLabelText
        nameTextField.text = viewModel.program.name
        
        nameTextField.configurePlaceholder(withText: viewModel.nameLabelText, font: .helveticaNeueThinWithSize18, textColor: .customGray)
        descriptionLabel.text = viewModel.descriptionLabelText
        descriptionTextField.text = viewModel.program.description
        descriptionTextField.configurePlaceholder(withText: viewModel.descriptionLabelText, font: .helveticaNeueThinWithSize18, textColor: .customGray)
    }

    @IBAction func nameTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        delegate?.didNameChange(text)
    }
    
    @IBAction func descriptionTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        delegate?.didDescriptionChange(text)
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: UITextField) { 
        underline(of: sender).backgroundColor = .customDarkYellow
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        let underline = underline(of: sender)
        underline.backgroundColor = sender.isTextEmpty ? .white : .customDarkYellow
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        let underline = underline(of: sender)
        underline.backgroundColor = sender.isTextEmpty ? .white : .customDarkYellow
        sender.resignFirstResponder()
    }
    
    private func underline(of textField: UITextField) -> UIView {
        if textField == nameTextField {
            return nameUnderlineView
        } else if textField == descriptionTextField {
            return descriptionUnderlineView
        } else {
            return UIView()
        }
    }
}
