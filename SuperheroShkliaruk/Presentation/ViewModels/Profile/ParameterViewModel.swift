//
//  ParameterViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import UIKit

final class ParameterViewModel {
    private enum Checkbox: String {
        case checked, unchecked
    }
    
    private let value: Int16
    let title: String
    let units: String
    var changedValue: Int16
    var isSelected: Bool
    var isDisplayed: Bool
    
    var isChecked: Bool
    let differenceValueString: String
    let differenceValueBackColor: UIColor
    var changedValueString: String {
        get {
            return changedValue != 0 ? String(changedValue) : ""
        }
        set {
            changedValue = Int16(newValue) ?? 0
        }
    }
    
    var checkboxImageName: String {
        return isChecked ? Checkbox.checked.rawValue : Checkbox.unchecked.rawValue
    }
    
    init(_ model: BodyParameter) {
        title = model.title
        units = model.units
        value = model.value
        changedValue = model.changedValue
        isSelected = model.isSelected
        isChecked = model.isSelected
        isDisplayed = model.isDisplayed
        
        let differenceValue = changedValue - value
        if differenceValue > 0 {
            differenceValueString = "+\(differenceValue)"
            differenceValueBackColor = .customRed
        } else if differenceValue < 0 {
            differenceValueString = "\(differenceValue)"
            differenceValueBackColor = .customGreen
        } else {
            differenceValueString = ""
            differenceValueBackColor = .clear
        }
    }
    
    func updateState() {
        isSelected = isChecked
    }
    
    func resetCheckbox() {
        isChecked = isSelected
    }
    
    func toggleCheckbox() {
        isChecked.toggle()
    }
    
    func resetCheckboxAndState() {
        isChecked = false
        isSelected = false
    }
}

extension ParameterViewModel: Equatable {
    static func == (lhs: ParameterViewModel, rhs: ParameterViewModel) -> Bool {
        guard lhs.value == rhs.value else { return false }
        guard lhs.changedValue == rhs.changedValue else { return false }
        guard lhs.isSelected == rhs.isSelected else { return false }
        guard lhs.isDisplayed == rhs.isDisplayed else { return false }
        return true
    }
}
