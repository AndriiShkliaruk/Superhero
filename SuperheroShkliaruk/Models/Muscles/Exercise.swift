//
//  Exercise.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 08.04.2022.
//

import Foundation

struct Exercise: Codable, Equatable {
    let name: String
    let icon: String
    let image: String
    let description: String
    let type: ExerciseType
    let equipment: Equipment
    let level: Level
    
    enum ExerciseType: String, Codable {
        case powerlifting = "Powerlifting"
        case bodybuilding = "Bodybuilding"
    }

    enum Equipment: String, Codable {
        case barbell = "Barbell"
        case ownWeight = "Own weight"
        case dumbbells = "Dumbbells"
        case trainer = "Trainer"
    }

    enum Level: String, Codable {
        case beginner = "Beginner"
        case normal = "Normal"
        case experienced = "Experienced"
    }
}
