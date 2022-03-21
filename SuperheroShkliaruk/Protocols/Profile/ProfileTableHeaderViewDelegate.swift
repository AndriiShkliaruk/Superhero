//
//  ProfileTableHeaderViewDelegate.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 20.03.2022.
//

import Foundation

protocol ProfileTableHeaderViewDelegate {
    func setProfileName(_ name: String)
    func setIsEnabledSaveButton(_ isEnabled: Bool)
}
