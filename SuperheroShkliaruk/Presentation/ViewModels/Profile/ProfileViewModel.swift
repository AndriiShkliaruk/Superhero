//
//  ProfileViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation
import CoreData

class ProfileViewModel {
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
    
    //MARK: - InfoView constants
    let infoIconName = "success"
    let infoText = "Profile has been saved!"
    
    private let initialUserProfile: UserProfileViewModel
    private var initialParameters: [BodyParameter]
    
    var userProfile: UserProfileViewModel
    var selectedParameters: [ParameterViewModel] {
        userProfile.parameters.filter { $0.isSelected }
    }
    var isSaveButtonEnabled: Bool {
        userProfile.isValidProperties && initialUserProfile != userProfile
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
                parameter.values = viewModel.values
                parameter.dates = viewModel.dates
                parameter.isSelected = viewModel.isSelected
                parameter.isDisplayed = viewModel.isDisplayed
            }
            return parameter
        }
    }
    
    func didSaveButtonTap() {
        coreDataProfile?.name = userProfile.name
        coreDataProfile?.avatar = userProfile.avatar
        
        saveValuesInParameterViewModels()
        updateInitialParameters(from: userProfile.parameters)
        coreDataProfile?.bodyParameters = NSOrderedSet(array: initialParameters)
        ProfileManager.sharedInstance.saveProfile()
    }
    
    func saveValuesInParameterViewModels() {
        userProfile.parameters.forEach { $0.addChangedValue() }
    }
    
    func updateParametersStates() {
        userProfile.parameters.forEach { $0.updateState() }
    }
    
    func resetParametersCheckboxes() {
        userProfile.parameters.forEach { $0.resetCheckbox() }
    }
    
    func deleteDisplayedParameter(_ parameter: ParameterViewModel) {
        parameter.deleteState()
    }
    
    func changeName(_ text: String) {
        userProfile.name = text
    }
    
    func changeAvatar(_ imageData: Data?) {
        userProfile.avatar = imageData
    }
}
