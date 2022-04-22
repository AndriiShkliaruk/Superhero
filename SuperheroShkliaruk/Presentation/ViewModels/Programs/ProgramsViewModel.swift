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
    
    func fetchProgramViewModels() -> [ProgramViewModel] {
        return programs.map { ProgramViewModel(mode: .edit(inputProgram: $0)) }
    }
}
