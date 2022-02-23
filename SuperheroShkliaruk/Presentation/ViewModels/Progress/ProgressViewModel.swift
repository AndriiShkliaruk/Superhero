//
//  ProgressViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.02.2022.
//

import Foundation

struct ProgressViewModel {
    private let profile = ProfileManager.sharedInstance.userProfile
    private let maleImageName = "home-male"
    private let femaleImageName = "home-female"
    
    public let navigationBarTitleText = "Прогресс"
    public let characterImageName: String
    
    init() {
        guard let sex = profile?.getSex() else {
            fatalError("Profile does not exist")
        }
        switch sex {
        case .male:
            characterImageName = maleImageName
        case .female:
            characterImageName = femaleImageName
        }
    }
}
