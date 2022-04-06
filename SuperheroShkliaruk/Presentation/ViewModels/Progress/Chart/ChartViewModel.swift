//
//  ChartViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 31.03.2022.
//

import Foundation

struct ChartViewModel {
    private let parameter: ParameterViewModel
    
    var chartBarViewModels = [ChartBarViewModel]()
    let descriptionLabelText: String = "Displaying dynamics relative to data from "
    var startDate: String {
        guard let date = parameter.dates.first else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: date)
    }
    
    var navigationBarTitle: String {
        "\(parameter.title) Chart"
    }
    
    var titleLabelText: String {
        "\(parameter.title), \(parameter.units)"
    }
    
    init(parameter: ParameterViewModel) {
        self.parameter = parameter
        createChartBarViewModels()
    }
    
    private mutating func createChartBarViewModels() {
        chartBarViewModels = parameter.values.enumerated().map { (index, value) in
            let prevValue = index != 0 ? parameter.values[index - 1] : nil
            return ChartBarViewModel(date: parameter.dates[index],
                                     prevValue: prevValue,
                                     value: value)
        }
    }
}
