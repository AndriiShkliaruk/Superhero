//
//  HomeViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation

struct HomeViewModel {
    private let profile = ProfileManager.sharedInstance.userProfile
    private let maleImageName = "home-male"
    private let maleLabelText = "Superman"
    private let femaleImageName = "home-female"
    private let femaleLabelText = "Supergirl"
    
    enum ViewControllerIDs: String, CaseIterable {
        case profile = "ProfileViewController"
        case progress = "ProgressViewController"
        case programs = "ProgramsViewController"
        case calculator = "CalculatorViewController"
        case muscles = "MusclesViewController"
    }
    
    let tableItems = ["Profile", "Progress", "Programs", "Calculator", "Muscles"]
    
    let characterImageName: String
    let characterLabel: String
    var profileName: String {
        return profile?.name ?? ""
    }
    
    init() {
        if let sex = profile?.getSex() {
            switch sex {
            case .male:
                characterImageName = maleImageName
                characterLabel = maleLabelText
            case .female:
                characterImageName = femaleImageName
                characterLabel = femaleLabelText
            }
        } else {
            fatalError("Profile does not exist")
        }
    }
    
    func pushToViewController(at indexPath: IndexPath, with coordinator: MainCoordinator?) {
        switch ViewControllerIDs.allCases[indexPath.row] {
        case .profile:
            coordinator?.moveToProfile()
        case .progress:
            coordinator?.moveToProgress()
        case .programs:
            coordinator?.moveToPrograms()
        case .calculator:
            coordinator?.moveToCalculator()
        case .muscles:
            coordinator?.moveToMuscles()
        }
    }
}
