//
//  HomeViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation

class HomeViewModel {
    private let coreDataProfile = ProfileManager.sharedInstance.userProfile
    private let parametersInstance = BodyParametersStorage.sharedInstance
    
    private enum CharacterLabelText: String {
        case superman, supergirl
    }
    
    let characterLabel: String
    var name: String {
        coreDataProfile?.name ?? ""
    }
    var avatarImageData: Data? {
        coreDataProfile?.avatar
    }
    var parametersViewModels = [ParameterViewModel]()
    
    init() {
        guard let sex = coreDataProfile?.getSex() else {
            fatalError("Profile does not exist")
        }
        switch sex {
        case .male:
            characterLabel = CharacterLabelText.superman.rawValue.capitalized
        case .female:
            characterLabel = CharacterLabelText.supergirl.rawValue.capitalized
        }
    }
    
    func updateParametersViewModels() {
        let coreDataParameters = parametersInstance.fetchBodyParameters()
        parametersViewModels = coreDataParameters.filter { $0.isDisplayed }
            .map { ParameterViewModel($0) }
    }
}
