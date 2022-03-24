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
    @IBOutlet private weak var unitsLabel: UILabel!
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
        
        unitsLabel.font = .helveticaNeueMediumWithSize18
        unitsLabel.textColor = .customGray
        
        isEnabledSwitch.onTintColor = .customYellow
        underlineView.backgroundColor = .white
    }
    
    func configure(with viewModel: BodyParameterViewModel) {
        parameterViewModel = viewModel
        
        bodyPartLabel.text = viewModel.title
        valueTextField.text = viewModel.value != 0 ? String(viewModel.value) : ""
        unitsLabel.text = viewModel.units
        isEnabledSwitch.isOn = viewModel.isDisplayed
    }
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        parameterViewModel?.isDisplayed = sender.isOn
    }
    
    @IBAction private func valueTextFieldEditingChanged(_ sender: UITextField) {
        guard let stringValue = sender.text else { return }
        parameterViewModel?.value = Int16(stringValue) ?? 0
    }
    
    @IBAction private func valueTextFieldEditingDidBegin(_ sender: UITextField) {
        underlineView.backgroundColor = .customDarkYellow
    }
    
    @IBAction private func valueTextFieldEditingDidEnd(_ sender: UITextField) {
        sender.updateUnderlineColor(underlineView: underlineView)
    }
    
    @IBAction private func valueTextFieldDidEndOnExit(_ sender: UITextField) {
        sender.updateUnderlineColor(underlineView: underlineView)
        sender.resignFirstResponder()
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
