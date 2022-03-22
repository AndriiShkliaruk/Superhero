//
//  StartViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation

struct StartViewModel {
    let titleLabelText = "Superhero"
    let subtitleLabelText = "choose a hero"
    
    let maleButtonText = "Superman"
    let femaleButtonText = "Supergirl"
    
    let manImageName = "start-male"
    let womanImageName = "start-female"
    
    func createNewUserWithSex(_ sex: String) {
        ProfileManager.sharedInstance.createDefaultProfileWith(sex)
    }
}
