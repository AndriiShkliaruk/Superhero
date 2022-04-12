//
//  MuscleGroup.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 08.04.2022.
//

import Foundation

struct MuscleGroup: Decodable {
    let muscleName: String
    let exercises: [Exercise]
}
