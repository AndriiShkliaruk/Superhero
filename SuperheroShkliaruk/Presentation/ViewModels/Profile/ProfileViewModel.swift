//
//  ProfileViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation
import CoreData

class ProfileViewModel {
    private let profile = ProfileManager.sharedInstance.userProfile
    
    public let navigationBarTitleText = "Profile"
    public let saveBarButtonText = "Save"
    public let nameLabelText = "Name"
    public let nameTextFieldPlaceholder = "Enter Name"
    public let descriptionLabelText = "Select an option to display on the main screen."
    public let addParametersButtonText = "Add options"
    
    public var profileName: String
    public var newProfileName = String()
    
    let parameters: [BodyParameter]
    var parametersViewModels = [BodyParameterViewModel]()
    var selectedParameters: [BodyParameterViewModel] {
        get {
            return parametersViewModels.filter { $0.isSelected }
        }
    }
    
    init() {
        profileName = profile?.name ?? ""
        parameters = BodyParametersStorage.sharedInstance.fetchBodyParameters()
        parametersViewModels = createViewModels(from: parameters)
    }
    
    private func createViewModels(from bodyParameters: [BodyParameter]) -> [BodyParameterViewModel] {
        let viewModels = bodyParameters.map { BodyParameterViewModel($0) }
        return viewModels
    }
    
    public func saveUserProfile() {
        guard !newProfileName.isEmpty && newProfileName != profileName else { return }
        ProfileManager.sharedInstance.userProfile?.name = newProfileName
        ProfileManager.sharedInstance.saveProfile()
    }
    
    public func updateParametersStates() {
        parametersViewModels.forEach { $0.updateState() }
    }
    
    public func resetParametersCheckboxes() {
        parametersViewModels.forEach { $0.resetCheckbox() }
    }
    
    public func deleteDisplayedParameter(_ parameter: BodyParameterViewModel) {
        parameter.resetCheckboxAndState()
    }
}
