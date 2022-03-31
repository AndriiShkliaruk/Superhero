//
//  ProgressViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

struct ProgressViewModel {
    private let parametersInstance = BodyParametersStorage.sharedInstance
    let navigationBarTitleText = "Progress"
    var parametersViewModels = [ParameterViewModel]()
    
    init() {
        let coreDataParameters = parametersInstance.fetchBodyParameters()
        parametersViewModels = coreDataParameters.filter { $0.isDisplayed }
            .map { ParameterViewModel($0) }
        
    }
}
