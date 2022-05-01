//
//  CalculatorModeViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 26.04.2022.
//

import Foundation

class CalculatorModeViewModel {
    typealias ParameterInput = (name: CalculatorParameter, units: CalculatorUnits)
    
    private let caloriesPerDay = "Calories/day"
    let navigationBarTitleText = "Calculator"
    let segmentedControlItems = ["Superman", "Superwoman"]
    let chooseActivityButtonText = "Choose Activity Level"
    let calculateButtonText = "Calculate"
    
    let titleLabelText: String
    let mode: CalculatorMode
    
    private var weight = 0.0
    private var height = 0.0
    private var neck = 0.0
    private var waist = 0.0
    private var hips = 0.0
    private var age = 0
    private var activityLevel: Double = 1
    private var sex: Sex = .male
    
    var parameterInputs = [ParameterInput]()
    let activityLevelViewModel: ActivityLevelViewModel
    
    private var resultValue: Double?
    var resultDescription: String?
    
    var stringResultValue: String? {
        if let value = resultValue, !value.isNaN {
            return String(format:"%.2f", value)
        } else {
            return "0.00"
        }
    }
    
    private var sexConstant: Int {
        sex == .male ? 5 : -161
    }
    
    var isCalculateButtonEnabled: Bool {
        switch mode {
        case .bmi:
            return !height.isZero && !weight.isZero
        case .fatPercentage:
            switch sex {
            case .male:
                return !height.isZero && !neck.isZero && !waist.isZero
            case .female:
                return !height.isZero && !neck.isZero && !waist.isZero && !hips.isZero
            }
        case .dailyCalorie:
            return !height.isZero && !weight.isZero && age != 0
        }
    }
    
    init(mode: CalculatorMode) {
        self.mode = mode
        titleLabelText = mode.description
        activityLevelViewModel = ActivityLevelViewModel(value: activityLevel)
        generateInputs()
    }
    
    private func generateInputs() {
        switch mode {
        case .bmi:
            parameterInputs = [(.height, .cm), (.weight, .kg)]
        case .fatPercentage:
            parameterInputs = [(.height, .cm), (.neck, .cm), (.waist, .cm), (.hips, .cm)]
        case .dailyCalorie:
            parameterInputs = [(.height, .cm), (.weight, .kg), (.age, .years)]
        }
    }
    
    func didCalculateTap() {
        switch mode {
        case .bmi:
            calculateBMI()
        case .fatPercentage:
            calculateFatPercentage()
        case .dailyCalorie:
            calculateDailyCaloriesRate()
        }
    }
    
    private func calculateBMI() {
        let total = weight / ((height * height) / 10000)
        resultValue = total
        
        switch total {
        case 0.01...16.0:
            resultDescription = BMILevel.tooLow.description
        case 16...18.5:
            resultDescription = BMILevel.low.description
        case 18.5...24.99:
            resultDescription = BMILevel.normal.description
        case 25...30:
            resultDescription = BMILevel.high.description
        case 30...35:
            resultDescription = BMILevel.toHigh.description
        case 35...40:
            resultDescription = BMILevel.extremlyHigh.description
        case 40...:
            resultDescription = BMILevel.toExtremlyHigh.description
        default:
            resultDescription = BMILevel.empty.description
        }
    }
    
    private func calculateFatPercentage() {
        let total = sex == .male ? (495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(height))) - 450 :
        (495 / (1.2958 - 0.35 * log10(waist + hips - neck) + 0.221 * log10(height))) - 450
        resultValue = total
        
        switch total {
        case 2.0...5.0:
            resultDescription = FatPercentLevel.toLow.description
        case 5.0...13.0:
            resultDescription = FatPercentLevel.low.description
        case 13.0...17.0:
            resultDescription = FatPercentLevel.notEnough.description
        case 17.0...22.0:
            resultDescription = FatPercentLevel.normal.description
        case 22.0...29.0:
            resultDescription = FatPercentLevel.high.description
        case 29.0...:
            resultDescription = FatPercentLevel.toHigh.description
        default:
            resultDescription = FatPercentLevel.empty.description
        }
    }
    
    private func calculateDailyCaloriesRate() {
        let total = (10 * weight + 6.25 * height - 5 * Double(age) + Double(sexConstant)) * activityLevel
        resultValue = total
        resultDescription = caloriesPerDay
    }
    
    func changeSex(_ index: Int) {
        sex = index == 0 ? .male : .female
    }
    
    func updateActivityLevel() {
        guard let value = activityLevelViewModel.selectedItem?.value else { return }
        activityLevel = value
    }
    
    func changeParameter(_ inputMode: CalculatorParameter, newValue: String) {
        switch inputMode {
        case .weight:
            weight = Double(newValue) ?? 0.0
        case .height:
            height = Double(newValue) ?? 0.0
        case .neck:
            neck = Double(newValue) ?? 0.0
        case .waist:
            waist = Double(newValue) ?? 0.0
        case .hips:
            hips = Double(newValue) ?? 0.0
        case .age:
            age = Int(newValue) ?? 0
        }
    }
}
