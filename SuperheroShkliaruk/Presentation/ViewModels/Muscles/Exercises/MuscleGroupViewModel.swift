//
//  MuscleGroupViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 10.04.2022.
//

import Foundation

class MuscleGroupViewModel {
    let chevronIcon = "chevron"
    
    let name: String
    var exercises: [ExerciseViewModel] = []
    
    var isOpen = false
    var selectedExercisesCount: String {
        String(exercises.filter { $0.isSelected }.count)
    }
    
    init(name: String, exercises: [Exercise]) {
        self.name = name
        
        guard !exercises.isEmpty else { return }
        self.exercises = createExerciseViewModels(from: exercises)
    }
    
    private func createExerciseViewModels(from exercises: [Exercise]) -> [ExerciseViewModel] {
        return exercises.map { exercise in
            ExerciseViewModel(exercise)
        }
    }
    
    func updateExercises(by inputExercises: [ExerciseViewModel]) {
        exercises.forEach { exercise in
            if inputExercises.contains(where: { $0.name == exercise.name }) {
                exercise.isSelected = true
            }
        }
    }
}

extension MuscleGroupViewModel: Equatable {
    static func == (lhs: MuscleGroupViewModel, rhs: MuscleGroupViewModel) -> Bool {
        guard lhs.name == rhs.name else { return false }
        guard lhs.exercises == rhs.exercises else { return false }
        return true
    }
    
    
}
