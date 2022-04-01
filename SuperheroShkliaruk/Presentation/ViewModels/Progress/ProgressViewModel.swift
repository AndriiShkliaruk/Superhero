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
    
    //MARK: - InfoView constants
    let infoIconName = "alert"
    let infoText = "Options are not selected.\nTo display them, add them to your profile."
    
    init() {
        let coreDataParameters = parametersInstance.fetchBodyParameters()
        parametersViewModels = coreDataParameters.filter { $0.isDisplayed }
            .map { ParameterViewModel($0) }
    }
}
