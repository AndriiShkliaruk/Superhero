//
//  ProgramViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 18.04.2022.
//

import Foundation

enum ProgramMode {
    case create(initialExercise: ExerciseViewModel?)
    case edit(inputProgram: Program)
}

class ProgramViewModel {
    let navigationBarTitleText = "Programs"
    let arrowImage = "chevron-right-white"
    var titleLabelText = "Add Program"
    let nameLabelText = "Name"
    let descriptionLabelText = "Description"
    let addExerciseButtonText = "Add Exercise"
    let saveBarButtonText = "Save"
    let backButtonText = "Back"
    
    //MARK: - InfoView constants
    let infoIconName = "success"
    let infoText = "Program has been saved!"
    
    private let initialProgram: Program
    var program: Program
    let mode: ProgramMode
    
    var isSaveButtonEnabled: Bool {
        switch mode {
        case .create:
            return program.isValidProperties
        case .edit:
            return program.isValidProperties && program != initialProgram
        }
    }
    
    init(mode: ProgramMode) {
        self.mode = mode
        
        switch mode {
        case .create(let initialExercise):
            program = Program(id: UUID().uuidString, name: "", description: nil, exercises: [])
            if let exercise = initialExercise {
                program.exercises.append(exercise)
            }
        case .edit(let inputProgram):
            titleLabelText = inputProgram.name
            self.program = inputProgram
        }
        initialProgram = program
    }
    
    func generateMusclesViewModel() -> MusclesViewModel {
        let musclesViewModel = MusclesViewModel()
        musclesViewModel.updateExercisesInMuscleGroups(by: program.exercises)
        return musclesViewModel
    }
    
    func didSaveButtonTap() {
        switch mode {
        case .create:
            ProgramsManager.sharedInstance.save(program)
        case .edit:
            ProgramsManager.sharedInstance.update(initialProgram, with: program)
        }
    }
    
    func changeName(_ text: String) {
        program.name = text
    }
    
    func changeDescription(_ text: String) {
        program.description = text
    }
    
    func changeExercises(by musclesViewModel: MusclesViewModel) {
        let exercises = musclesViewModel.muscleGroupViewModels.flatMap { $0.exercises }
        let selectedExercises = exercises.filter { $0.isSelected }
        program.exercises = selectedExercises
    }
}
