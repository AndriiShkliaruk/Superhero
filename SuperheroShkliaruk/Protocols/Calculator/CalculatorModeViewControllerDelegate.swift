//
//  CalculatorModeViewControllerDelegate.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 30.04.2022.
//

import Foundation

protocol CalculatorModeViewControllerDelegate {
    func didTapConfirm()
    func didTapClose()
    func didChangeParameter(_ inputMode: CalculatorParameter, newValue: String)
}
