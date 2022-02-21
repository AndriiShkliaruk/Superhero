//
//  HomeViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation

struct HomeViewModel {
    private let maleImageName = "home-male"
    private let maleLabelText = "Superman"
    private let femaleImageName = "home-female"
    private let femaleLabelText = "Supergirl"
    
    public var characterImageName: String
    public var characterLabelText: String
    
    init() {
        let profile = ProfileManager.sharedInstance.userProfile!
        let sex = Sex(rawValue: profile.sex)
        switch sex {
        case .male:
            characterImageName = maleImageName
            characterLabelText = maleLabelText
        case .female:
            characterImageName = femaleImageName
            characterLabelText = femaleLabelText
        default:
            characterImageName = maleImageName
            characterLabelText = maleLabelText
            debugPrint("User is not created")
        }
    }
    
}
