//
//  BodyParameterViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import Foundation

class BodyParameterViewModel {
    private let checkedImageName = "checked"
    private let uncheckedImageName = "unchecked"
    
    let title: String
    let valueType: String
    var value: Int
    var isSelected: Bool
    var isChecked: Bool
    var isDisplayed: Bool
    
    var checkboxImageName: String {
        get {
            return isChecked ? checkedImageName : uncheckedImageName
        }
    }
    
    init(_ model: BodyParameter) {
        title = model.title
        valueType = model.valueType
        value = Int(model.value)
        isSelected = model.isSelected
        isChecked = model.isSelected
        isDisplayed = model.isDisplayed
    }
    
    public func updateState() {
        isSelected = isChecked
    }
    
    public func resetCheckbox() {
        isChecked = isSelected
    }
    
    public func toggleCheckbox() {
        isChecked.toggle()
    }
    
    public func resetCheckboxAndState() {
        isChecked = false
        isSelected = false
    }
}
