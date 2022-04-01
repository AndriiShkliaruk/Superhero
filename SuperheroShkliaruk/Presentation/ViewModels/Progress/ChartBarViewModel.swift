//
//  ChartBarViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 01.04.2022.
//

import UIKit

struct ChartBarViewModel {
    private let date: Date
    private let value: Int16
    private let units: String
    
    let differenceValueString: String
    let differenceValueBackColor: UIColor
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: date)
    }
    
    var valueString: String {
        "\(String(value)) \(units)"
    }
    
    init(date: Date, prevValue: Int16?, value: Int16, units: String) {
        self.date = date
        self.value = value
        self.units = units
        
        guard let oldValue = prevValue else {
            differenceValueString = ""
            differenceValueBackColor = .clear
            return
        }
        
        let difference = value - oldValue
        if difference > 0 {
            differenceValueString = "+\(difference)"
            differenceValueBackColor = .customRed
        } else {
            differenceValueString = "\(difference)"
            differenceValueBackColor = .customGreen
        }
    }
}
