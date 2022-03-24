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
    private let model: BodyParameter
    var delegate: ProfileViewControllerDelegate?
    var isChanged = false 
    
    let title: String
    let units: String
    var isChecked: Bool
    
    var value: Int16 {
        didSet {
            updateChanges()
        }
    }
    var isSelected: Bool {
        didSet {
            updateChanges()
        }
    }
    var isDisplayed: Bool {
        didSet {
            updateChanges()
        }
    }
    var checkboxImageName: String {
        return isChecked ? checkedImageName : uncheckedImageName
    }
    
    init(_ model: BodyParameter) {
        self.model = model
        title = model.title
        units = model.units
        value = model.value
        isSelected = model.isSelected
        isChecked = model.isSelected
        isDisplayed = model.isDisplayed
    }
    
    private func updateChanges() {
        if value != model.value || isSelected != model.isSelected || isDisplayed != model.isDisplayed {
            isChanged = true
        } else {
            isChanged = false
        }
        delegate?.updateSaveButtonState()
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
