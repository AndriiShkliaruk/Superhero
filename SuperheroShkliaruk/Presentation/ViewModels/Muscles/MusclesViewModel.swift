//
//  MusclesViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

class MusclesViewModel {
    let navigationBarTitleText = "Muscles"
    let saveBarButtonText = "Save"
    
    var muscleGroupViewModels: [MuscleGroupViewModel] = []
    
    init() {
        let muscleGroups = ExercisesStorage().fetchExercisesByMyscleTypes()
        muscleGroupViewModels = createMuscleGroupViewModels(from: muscleGroups)
    }
    
    private func createMuscleGroupViewModels(from muscleGroups: [MuscleGroup]) -> [MuscleGroupViewModel] {
        return muscleGroups.map { model in
            MuscleGroupViewModel(name: model.muscleName, exercises: model.exercises)
        }
    }
}
