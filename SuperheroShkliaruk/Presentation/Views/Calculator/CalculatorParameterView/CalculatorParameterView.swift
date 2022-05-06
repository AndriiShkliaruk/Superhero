//
//  CalculatorParameterView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 26.04.2022.
//

import UIKit

class CalculatorParameterView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var unitsLabel: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    var inputMode: CalculatorParameter?
    var delegate: CalculatorModeViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.font = .helveticaNeueRegularWithSize18
        nameLabel.textColor = .white
        
        valueTextField.font = .helveticaNeueRegularWithSize18
        valueTextField.textColor = .customGray
        valueTextField.delegate = self
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneKeyboardButtonPressed))
        valueTextField.showButtonOnKeyboard(doneButton)
        
        unitsLabel.font = .helveticaNeueMediumWithSize18
        unitsLabel.textColor = .customGray
        underlineView.backgroundColor = .white
    }
    
    func configure(_ name: CalculatorParameter, units: CalculatorUnits, textFieldTag: Int) {
        inputMode = name
        nameLabel.text = name.description
        unitsLabel.text = units.description
        valueTextField.tag = textFieldTag
    }
    
    @objc private func doneKeyboardButtonPressed() {
        let nextTag = valueTextField.tag + 1
        
        guard let nextResponder = superview?.viewWithTag(nextTag) as? UITextField else {
            endEditing(true)
            return
        }
        guard let nextView = nextResponder.superview?.superview, !nextView.isHidden else {
            endEditing(true)
            return
        }
        nextResponder.becomeFirstResponder()
    }
    
    @IBAction func valueTextFieldEditingChanged(_ sender: UITextField) {
        guard let stringValue = sender.text, let mode = inputMode else { return }
        delegate?.didChangeParameter(mode, newValue: stringValue)
    }
    
    @IBAction func valueTextFieldEditingDidBegin(_ sender: UITextField) {
        underlineView.backgroundColor = .customDarkYellow
    }
    
    @IBAction func valueTextFieldEditingDidEnd(_ sender: UITextField) {
        underlineView.backgroundColor = sender.isTextEmpty ? .white : .customDarkYellow
    }
    
    @IBAction func valueTextFieldDidEndOnExit(_ sender: UITextField) {
        underlineView.backgroundColor = sender.isTextEmpty ? .white : .customDarkYellow
        sender.resignFirstResponder()
    }
}

extension CalculatorParameterView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 3
    }
}
