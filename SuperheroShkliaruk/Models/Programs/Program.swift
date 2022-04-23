//
//  Program.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.04.2022.
//

import Foundation

struct Program: Codable, Equatable {
    private(set) var infoIconName = "success"
    
    let id: String
    var name: String
    var description: String?
    var exercises: [ExerciseViewModel]
    
    var isValidProperties: Bool {
        return !name.isEmpty && !exercises.isEmpty
    }
    var exerciseAddedInfoText: String {
        "Exercise has been added to the \(name)!"
    }
}
