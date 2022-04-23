//
//  ProgramsViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

class ProgramsViewModel {
    let navigationBarTitleText = "Programs"
    let titleLabelText = "Your Programs"
    let newProgramButtonText = "Create New Program"
    
    var programs: [Program] = []
    
    func updateProgramViewModels() {
        programs = ProgramsManager.sharedInstance.fetchPrograms()
    }
    
    func fetchProgramViewModel(at index: Int) -> ProgramViewModel {
        return ProgramViewModel(mode: .edit(inputProgram: programs[index]))
    }
    
    func deleteProgram(at index: Int) {
        ProgramsManager.sharedInstance.delete(at: index)
        updateProgramViewModels()
    }
}
