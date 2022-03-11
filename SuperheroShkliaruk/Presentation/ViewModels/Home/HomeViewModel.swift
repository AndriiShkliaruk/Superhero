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
    
    let tableItems = ["Профиль", "Прогресс", "Программы", "Калькулятор", "Мышцы", "Профиль", "Прогресс", "Программы", "Калькулятор", "Мышцы"]
    
    public let characterImageName: String
    public let characterLabelText: String
    
    init() {
        guard let sex = profile?.getSex() else {
            fatalError("Profile does not exist")
        }
        switch sex {
        case .male:
            characterImageName = maleImageName
            characterLabelText = maleLabelText
        case .female:
            characterImageName = femaleImageName
            characterLabelText = femaleLabelText
        }
    }
    
    func pushToViewController(at indexPath: IndexPath, with coordinator: MainCoordinator?) {
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
