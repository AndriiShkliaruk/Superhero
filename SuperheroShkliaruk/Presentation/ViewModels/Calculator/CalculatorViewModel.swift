//
//  CalculatorViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

enum CalculatorType: String, CaseIterable {
    case BMI = "Body Mass Index"
    case fatPercentage = "Fat Percentage"
    case dailyCalorie = "Daily Calorie Requirement"
}

struct CalculatorViewModel {
    let navigationBarTitleText = "Calculator"
    
    var tableItems: [String] {
        CalculatorType.allCases.map { $0.rawValue }
    }
}
