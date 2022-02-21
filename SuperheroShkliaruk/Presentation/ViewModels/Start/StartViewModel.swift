//
//  StartViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation

struct StartViewModel {
    public let titleLabelText = "SUPERHERO"
    public let subtitleLabelText = "выберите героя"
    
    public let maleButtonText = "SUPERMAN"
    public let femaleButtonText = "SUPERGIRL"
    
    public let manImageName = "start-male"
    public let womanImageName = "start-female"
    
    public func createNewUserWithSex(_ sex: String) {
        ProfileManager.sharedInstance.createDefaultProfileWith(sex)
    }
}
