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
    
    var isSelected: Bool
    var isChecked: Bool
    let title: String
    var checkboxImageName: String {
        get {
            return isChecked ? checkedImageName : uncheckedImageName
        }
    }
    
    init(_ model: BodyParameter) {
        title = model.title
        isSelected = model.isSelected
        isChecked = model.isSelected
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
