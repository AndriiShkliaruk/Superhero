//
//  BaseViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import Foundation

struct BaseViewModel {
    private let profile = ProfileManager.sharedInstance.userProfile
    private let maleImageName = "home-male"
    private let femaleImageName = "home-female"
    
    public let characterImageName: String
    
    init() {
        if let sex = profile?.getSex() {
            switch sex {
            case .male:
                characterImageName = maleImageName
            case .female:
                characterImageName = femaleImageName
            }
        } else {
            //fatalError("Profile does not exist")
            characterImageName = maleImageName
        }
    }
}
