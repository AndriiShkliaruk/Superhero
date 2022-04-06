//
//  ChartBarViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 01.04.2022.
//

import UIKit

struct ChartBarViewModel {
    let date: String
    let value: Int16
    let difference: String
    let differenceBackColor: UIColor
    
    init(date: Date, prevValue: Int16?, value: Int16) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        self.date = dateFormatter.string(from: date)

        self.value = value
        
        guard let oldValue = prevValue else {
            difference = ""
            differenceBackColor = .clear
            return
        }
        
        let differenceValue = value - oldValue
        if differenceValue > 0 {
            difference = "+\(differenceValue)"
            differenceBackColor = .customRed
        } else {
            difference = "\(differenceValue)"
            differenceBackColor = .customGreen
        }
    }
}
