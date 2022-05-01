//
//  CalculatorEnums.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 28.04.2022.
//

import Foundation

enum CalculatorParameter: String {
    case weight, height, neck, waist, hips, age
    
    var description: String {
        rawValue.capitalized
    }
}

enum CalculatorUnits: String {
    case kg, cm, years
    
    var description: String {
        rawValue
    }
}

enum DailyCaloriesRateAtivityLevel: Double, CaseIterable {
    case sitting = 1.2
    case light = 1.38
    case middle = 1.56
    case high = 1.73
    case extremal = 1.95
    
    var value: Double {
        rawValue
    }
    
    var description: String {
        switch self {
        case .sitting:
            return "Passive lifestyle"
        case .light:
            return "Light activity (1-3 times a week)"
        case .middle:
            return "Medium activity (training 3-5 times a week)"
        case .high:
            return "High activity (training 6-7 times a week)"
        case .extremal:
            return "Extreme high activity"
        }
    }
}

extension CalculatorModeViewModel {
    enum BMILevel: String {
        case tooLow = "Severe underweight"
        case low = "Underweight"
        case normal = "Normal"
        case high = "Overweight"
        case toHigh = "Obesity"
        case extremlyHigh = "High obesity"
        case toExtremlyHigh = "Very high obesity"
        case empty = "Please enter valid values"
        
        var description: String {
            rawValue
        }
    }
    
    enum FatPercentLevel: String {
        case toLow = "Severe underweight"
        case low = "Very underweight"
        case notEnough = "Underweight"
        case normal = "Normal"
        case high = "Overweight"
        case toHigh = "Obesity"
        case empty = "Please enter valid values"
        
        var description: String {
            rawValue
        }
    }
}
