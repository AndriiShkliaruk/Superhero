//
//  ExerciseViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 10.04.2022.
//

import Foundation

class ExerciseViewModel: Codable {
    private(set) var navigationBarTitle = "Exercise"
    private(set) var addButtonTitle = "Add to Program"
    private(set) var moreButtonText = "More about"
    private(set) var moreButtonIcon = "arrow-right"
    private(set) var newProgramActionTitle = "Create New Program"
    
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

extension ExerciseViewModel: Equatable {
    static func == (lhs: ExerciseViewModel, rhs: ExerciseViewModel) -> Bool {
        guard lhs.name == rhs.name else { return false }
        guard lhs.isSelected == rhs.isSelected else { return false }
        return true
    }
}
