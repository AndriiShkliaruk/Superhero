//
//  BaseViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import Foundation

struct BaseViewModel {
    private let profile = ProfileManager.sharedInstance.userProfile
    private enum CharacterImageName: String {
        case male = "base-male"
        case female = "base-female"
    }
    
    let characterImageName: String
    
    init() {
        if let sex = profile?.getSex() {
            switch sex {
            case .male:
                characterImageName = CharacterImageName.male.rawValue
            case .female:
                characterImageName = CharacterImageName.female.rawValue
            }
        } else {
            characterImageName = CharacterImageName.male.rawValue
        }
    }
}
