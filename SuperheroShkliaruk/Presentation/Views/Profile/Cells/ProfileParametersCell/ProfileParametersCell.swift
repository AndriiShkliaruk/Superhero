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
    private var parameterViewModel: ParameterViewModel?
    var delegate: ProfileViewControllerDelegate?
    
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
    }
    
    func configure(with viewModel: ParameterViewModel, textFieldTag: Int) {
        parameterViewModel = viewModel
        
        bodyPartLabel.text = viewModel.title
        valueTextField.text = viewModel.changedValueString
        unitsLabel.text = viewModel.units
        isEnabledSwitch.isOn = viewModel.isDisplayed
        underlineView.backgroundColor = .white
        
        valueTextField.tag = textFieldTag
        addDoneButtonOnKeyboard()
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneKeyboardButtonPressed))
        done.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        done.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .highlighted)
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        valueTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneKeyboardButtonPressed() {
        let nextTag = valueTextField.tag + 1
        
        if let nextResponder = superview?.viewWithTag(nextTag) as? UITextField {
            nextResponder.becomeFirstResponder()
        } else {
            endEditing(true)
        }
    }
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        parameterViewModel?.changeIsDisplayed(sender.isOn)
        delegate?.updateSaveButtonState()
    }
    
    @IBAction private func valueTextFieldEditingChanged(_ sender: UITextField) {
        guard let stringValue = sender.text else { return }
        parameterViewModel?.changeValue(stringValue)
        delegate?.updateSaveButtonState()
    }
    
    @IBAction private func valueTextFieldEditingDidBegin(_ sender: UITextField) {
        underlineView.backgroundColor = .customDarkYellow
        delegate?.didActiveCellChange(self)
    }
    
    @IBAction private func valueTextFieldEditingDidEnd(_ sender: UITextField) {
        underlineView.backgroundColor = sender.isTextEmpty ? .white : .customDarkYellow
        delegate?.didActiveCellChange(nil)
    }
    
    @IBAction private func valueTextFieldDidEndOnExit(_ sender: UITextField) {
        underlineView.backgroundColor = sender.isTextEmpty ? .white : .customDarkYellow
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
