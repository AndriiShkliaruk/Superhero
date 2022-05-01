//
//  ActivityLevelViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 28.04.2022.
//

import Foundation

class ActivityLevelViewModel {
    let activityLevelTitleLabelText = "Choose Your Activity Level"
    let confirmButtonText = "Confirm"
    
    enum OptionIcon: String {
        case selected = "option-selected"
        case deselected = "option-deselected"
    }
    
    let activityItems = DailyCaloriesRateAtivityLevel.allCases
    private var initialSelectedItem: DailyCaloriesRateAtivityLevel?
    var selectedItem: DailyCaloriesRateAtivityLevel?
    
    init(value: Double) {
        initialSelectedItem = DailyCaloriesRateAtivityLevel(rawValue: value)
        selectedItem = DailyCaloriesRateAtivityLevel(rawValue: value)
    }
    
    func icon(for item: DailyCaloriesRateAtivityLevel) -> String {
        return item == selectedItem ? OptionIcon.selected.rawValue : OptionIcon.deselected.rawValue
    }
    
    func setSelectedItem(_ item: DailyCaloriesRateAtivityLevel) {
        selectedItem = item
    }
    
    func confirmSelectedItem() {
        initialSelectedItem = selectedItem
    }
    
    func resetSelectedItem() {
        selectedItem = initialSelectedItem
    }
}
