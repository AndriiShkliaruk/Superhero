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
    
    let navigationBarTitleText = "Profile"
    let saveBarButtonText = "Save"
    let nameLabelText = "Name"
    let nameTextFieldPlaceholder = "Enter Name"
    let descriptionLabelText = "Select an option to display on the main screen."
    let addParametersButtonText = "Add options"
    let defaultAvatarName = "camera"
    
    let name: String
    var newName: String
    var avatarData: Data?
    var isAvatarChanged = false
    
    var parameters: [BodyParameter]
    var parametersViewModels = [BodyParameterViewModel]()
    var selectedParameters: [BodyParameterViewModel] {
        return parametersViewModels.filter { $0.isSelected }
    }
    
    init() {
        name = profile?.name ?? ""
        newName = name
        avatarData = profile?.avatar
        
        parameters = BodyParametersStorage.sharedInstance.fetchBodyParameters()
        parametersViewModels = createViewModels(from: parameters)
    }
    
    private func createViewModels(from bodyParameters: [BodyParameter]) -> [BodyParameterViewModel] {
        let viewModels = bodyParameters.map { BodyParameterViewModel($0) }
        return viewModels
    }
    
    private func updateParametersFromViewModels() {
        parameters = parameters.map { parameter in
            if let viewModel = parametersViewModels.first(where: { $0.title == parameter.title }) {
                parameter.value = viewModel.value
                parameter.isSelected = viewModel.isSelected
                parameter.isDisplayed = viewModel.isDisplayed
            }
            return parameter
        }
    }
    
    func stateHasChanges() -> Bool {
        let isNewNameEmpty = newName.isEmpty
        let isNameChanged = newName != name
        let isParametersChanged = parametersViewModels.contains(where: { $0.isChanged })
        return (!isNewNameEmpty && (isNameChanged || isParametersChanged)) || (isAvatarChanged && !isNewNameEmpty)
//        return (isNewNameEmpty && isParametersChanged) || ((isNameChanged || isParametersChanged) && !isNewNameEmpty)
    }
    
    func saveUserProfile() {
        profile?.name = newName
        profile?.avatar = avatarData
        updateParametersFromViewModels()
        profile?.bodyParameters = NSOrderedSet(array: parameters)
        ProfileManager.sharedInstance.saveProfile()
    }
    
    func updateParametersStates() {
        parametersViewModels.forEach { $0.updateState() }
    }
    
    func resetParametersCheckboxes() {
        parametersViewModels.forEach { $0.resetCheckbox() }
    }
    
    func deleteDisplayedParameter(_ parameter: BodyParameterViewModel) {
        parameter.resetCheckboxAndState()
    }
}
