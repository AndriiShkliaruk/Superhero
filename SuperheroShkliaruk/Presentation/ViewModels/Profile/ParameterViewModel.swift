//
//  ParameterViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import UIKit

class ParameterViewModel {
    private enum Checkbox: String {
        case checked, unchecked
    }
    
    let title: String
    let units: String
    var values: [Int16]
    var dates: [Date]
    var isSelected: Bool
    var isDisplayed: Bool
    
    var isChecked: Bool
    let differenceValueString: String
    let differenceValueBackColor: UIColor
    var changedValue: Int16
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
        values = model.values
        dates = model.dates
        isSelected = model.isSelected
        isChecked = model.isSelected
        isDisplayed = model.isDisplayed
        changedValue = model.values.last ?? 0
        
        guard values.count > 1 else {
            differenceValueString = ""
            differenceValueBackColor = .clear
            return
        }
        
        let differenceValue = changedValue - values.first!
        if differenceValue > 0 {
            differenceValueString = "+\(differenceValue)"
            differenceValueBackColor = .customRed
        } else {
            differenceValueString = "\(differenceValue)"
            differenceValueBackColor = .customGreen
        }
    }
    
    func addChangedValue() {
        guard changedValue != 0 && changedValue != values.last else { return }
        let currentDate = Date()
        
        guard !values.isEmpty else {
            values.append(changedValue)
            dates.append(currentDate)
            return
        }
        
        guard let lastDate = dates.last else { return }
        let datesOrder = Calendar.current.compare(currentDate, to: lastDate, toGranularity: .day)
        switch datesOrder {
        case .orderedSame:
            values[values.count - 1] = changedValue
            dates[dates.count - 1] = currentDate
        case .orderedDescending:
            values.append(changedValue)
            dates.append(currentDate)
        default:
            break
        }
    }
    
    func updateState() {
        isSelected = isChecked
        if !isSelected {
            isDisplayed = false
        }
    }
    
    func resetCheckbox() {
        isChecked = isSelected
    }
    
    func toggleCheckbox() {
        isChecked.toggle()
    }
    
    func deleteState() {
        isChecked = false
        isSelected = false
        isDisplayed = false
    }
}

extension ParameterViewModel: Equatable {
    static func == (lhs: ParameterViewModel, rhs: ParameterViewModel) -> Bool {
        guard lhs.changedValue == rhs.changedValue else { return false }
        guard lhs.isSelected == rhs.isSelected else { return false }
        guard lhs.isDisplayed == rhs.isDisplayed else { return false }
        return true
    }
}
