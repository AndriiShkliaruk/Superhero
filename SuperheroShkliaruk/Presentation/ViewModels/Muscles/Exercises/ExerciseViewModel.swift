//
//  ExerciseViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 10.04.2022.
//

import Foundation

class ExerciseViewModel {
    let navigationBarTitle = "Exercise"
    let addButtonTitle = "Add to Program"
    let moreButtonText = "More about"
    let moreButtonIcon = "arrow-right"
    
    let name: String
    let icon: String
    let image: String
    let description: String
    let options: String
    var isSelected = false
    
    init(_ model: Exercise) {
        name = model.name
        icon = "barbell"
        image = model.image
        description = model.description
        options = "\(model.equipment.rawValue), \(model.level.rawValue), \(model.type.rawValue)"
    }
}
