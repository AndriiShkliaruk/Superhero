//
//  ProfileViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

struct ProfileViewModel {
    private let profile = ProfileManager.sharedInstance.userProfile
    private let maleImageName = "home-male"
    private let femaleImageName = "home-female"
    
    public let navigationBarTitleText = "Profile"
    public let characterImageName: String
    public let saveBarButtonText = "Save"
    public let nameLabelText = "Name"
    public let nameTextFieldPlaceholder = "Enter Name"
    public let descriptionLabelText = "Select an option to display on the main screen."
    public let addParametersButtonText = "Add options"
    
    public var profileName: String
    public var profileNewName = String()
    
    init() {
        if let sex = profile?.getSex() {
            switch sex {
            case .male:
                characterImageName = maleImageName
            case .female:
                characterImageName = femaleImageName
            }
        } else {
            fatalError("Profile does not exist")
        }
        
        profileName = profile?.name ?? ""
    }
    
    public func saveUserProfile() {
        guard !profileNewName.isEmpty && profileNewName != profileName else { return }
        ProfileManager.sharedInstance.userProfile?.name = profileNewName
        ProfileManager.sharedInstance.saveProfile()
    }
}
