//
//  CalculatorViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

enum CalculatorMode: String, CaseIterable {
    case bmi = "Body Mass Index"
    case fatPercentage = "Fat Percentage"
    case dailyCalorie = "Daily Calorie Requirement"
    
    var description: String {
        rawValue
    }
}

struct CalculatorViewModel {
    let navigationBarTitleText = "Calculator"
    
    var tableItems: [String] {
        CalculatorMode.allCases.map { $0.description }
    }
}
