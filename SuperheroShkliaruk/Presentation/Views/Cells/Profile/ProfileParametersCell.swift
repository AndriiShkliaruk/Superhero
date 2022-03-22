//
//  ProfileParametersCell.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import UIKit

class ProfileParametersCell: UITableViewCell {
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var bodyPartLabel: UILabel!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var valueType: UILabel!
    @IBOutlet private weak var isEnabledSwitch: UISwitch!
    @IBOutlet private weak var underlineView: UIView!
    
    static let identifier = "ProfileParametersCell"
    private var parameterViewModel: BodyParameterViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        backView.backgroundColor = .clear
        
        bodyPartLabel.font = .helveticaNeueRegularWithSize18
        bodyPartLabel.textColor = .white
        
        valueTextField.font = .helveticaNeueRegularWithSize18
        valueTextField.textColor = .customGray
        valueTextField.delegate = self
        
        valueType.font = .helveticaNeueMediumWithSize18
        valueType.textColor = .customGray
        
        isEnabledSwitch.onTintColor = .customYellow
        underlineView.backgroundColor = .customDarkYellow
    }
    
    func configure(with viewModel: BodyParameterViewModel) {
        parameterViewModel = viewModel
        
        bodyPartLabel.text = viewModel.title
        valueTextField.text = viewModel.value != 0 ? String(viewModel.value) : ""
        valueType.text = viewModel.valueType
        isEnabledSwitch.isOn = viewModel.isDisplayed
    }
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        parameterViewModel?.isDisplayed = sender.isOn
    }
    
    @IBAction private func valueTextFieldEditingChanged(_ sender: UITextField) {
        guard let stringValue = sender.text else { return }
        parameterViewModel?.value = Int16(stringValue) ?? 0
    }
}

extension ProfileParametersCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 3
    }
}
