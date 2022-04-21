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
    
    private var initialMuscleGroupViewModels: [MuscleGroupViewModel] = []
    var muscleGroupViewModels: [MuscleGroupViewModel] = []
    
    var isSaveButtonEnabled: Bool {
        return !muscleGroupViewModels.isEmpty && muscleGroupViewModels != initialMuscleGroupViewModels
    }
    
    init() {
        let muscleGroups = ExercisesStorage.sharedInstance.fetchMyscleGroups()
        muscleGroupViewModels = createMuscleGroupViewModels(from: muscleGroups)
        initialMuscleGroupViewModels = createMuscleGroupViewModels(from: muscleGroups)
    }
    
    private func createMuscleGroupViewModels(from muscleGroups: [MuscleGroup]) -> [MuscleGroupViewModel] {
        return muscleGroups.map { model in
            MuscleGroupViewModel(name: model.muscleName, exercises: model.exercises)
        }
    }
    
    func updateExercisesInMuscleGroups(by inputExercises: [ExerciseViewModel]) {
        muscleGroupViewModels.forEach { $0.updateExercises(by: inputExercises) }
        initialMuscleGroupViewModels.forEach { $0.updateExercises(by: inputExercises) }
    }
}
