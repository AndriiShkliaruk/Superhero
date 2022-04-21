//
//  ProgramViewControllerDelegate.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 20.04.2022.
//

import Foundation

protocol ProgramViewControllerDelegate {
    func didNameChange(_ text: String)
    func didDescriptionChange(_ text: String)
    func didExercisesChange(_ musclesViewModel: MusclesViewModel)
}
