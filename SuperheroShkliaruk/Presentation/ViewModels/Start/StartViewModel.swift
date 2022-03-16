//
//  StartViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation

struct StartViewModel {
    public let titleLabelText = "Superhero"
    public let subtitleLabelText = "choose a hero"
    
    public let maleButtonText = "Superman"
    public let femaleButtonText = "Supergirl"
    
    public let manImageName = "start-male"
    public let womanImageName = "start-female"
    
    public func createNewUserWithSex(_ sex: String) {
        ProfileManager.sharedInstance.createDefaultProfileWith(sex)
    }
}
