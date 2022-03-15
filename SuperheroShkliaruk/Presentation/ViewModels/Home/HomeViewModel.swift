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
    
    let tableItems = ["Профиль", "Прогресс", "Программы", "Калькулятор", "Мышцы"]
    
    public let characterImageName: String
    public let characterLabel: String
    public var profileName: String {
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
    
    public func pushToViewController(at indexPath: IndexPath, with coordinator: MainCoordinator?) {
        switch ViewControllerIDs.allCases[indexPath.row] {
        case .profile:
            coordinator?.presentProfile()
        case .progress:
            coordinator?.presentProgress()
        case .programs:
            coordinator?.presentPrograms()
        case .calculator:
            coordinator?.presentCalculator()
        case .muscles:
            coordinator?.presentMuscles()
        }
    }
    
}
