//
//  ProfileViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation
import CoreData

final class ProfileViewModel {
    private let coreDataProfile = ProfileManager.sharedInstance.userProfile
    
    //MARK: - ProfileViewController constants
    let navigationBarTitleText = "Profile"
    let saveBarButtonText = "Save"
    let nameLabelText = "Name"
    let nameTextFieldPlaceholder = "Enter Name"
    let descriptionLabelText = "Select an option to display on the main screen."
    let addParametersButtonText = "Add Options"
    let defaultAvatarName = "camera"
    
    //MARK: - ParametersViewController constants
    let topLabelText = "Select Option"
    let cancelButtonText = "Cancel"
    let selectButtonText = "Select"
    
    private let initialUserProfile: UserProfileViewModel
    private var initialParameters: [BodyParameter]
    
    var userProfile: UserProfileViewModel
    var selectedParameters: [ParameterViewModel] {
        userProfile.parameters.filter { $0.isSelected }
    }
    
    init() {
        guard let profile = coreDataProfile else {
            fatalError("Profile does not exist")
        }
        initialParameters = BodyParametersStorage.sharedInstance.fetchBodyParameters()
        let initialParametersViewModels = initialParameters.map { ParameterViewModel($0) }
        let parametersViewModels = initialParameters.map { ParameterViewModel($0) }
        initialUserProfile = UserProfileViewModel(profile, initialParametersViewModels)
        userProfile = UserProfileViewModel(profile, parametersViewModels)
    }
    
    private func updateInitialParameters(from viewModels: [ParameterViewModel]) {
        initialParameters = initialParameters.map { parameter in
            if let viewModel = viewModels.first(where: { $0.title == parameter.title }) {
                if parameter.value == 0 {
                    parameter.value = viewModel.changedValue
                }
                parameter.changedValue = viewModel.changedValue
                parameter.isSelected = viewModel.isSelected
                parameter.isDisplayed = viewModel.isDisplayed
            }
            return parameter
        }
    }
    
    private func isValidValues(in parameters: [ParameterViewModel]) -> Bool {
        return !parameters.contains(where: { $0.isSelected && $0.changedValue == 0 })
    }
    
    func stateHasChanges() -> Bool {
        guard isValidValues(in: userProfile.parameters) else { return false }
        return initialUserProfile != userProfile
    }
    
    func saveUserProfile() {
        coreDataProfile?.name = userProfile.name
        coreDataProfile?.avatar = userProfile.avatar
        
        updateInitialParameters(from: userProfile.parameters)
        coreDataProfile?.bodyParameters = NSOrderedSet(array: initialParameters)
        ProfileManager.sharedInstance.saveProfile()
    }
    
    func updateParametersStates() {
        userProfile.parameters.forEach { $0.updateState() }
    }
    
    func resetParametersCheckboxes() {
        userProfile.parameters.forEach { $0.resetCheckbox() }
    }
    
    func deleteDisplayedParameter(_ parameter: ParameterViewModel) {
        parameter.resetCheckboxAndState()
    }
}
