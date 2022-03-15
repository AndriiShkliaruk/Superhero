//
//  Profile+Sex.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 15.03.2022.
//

import Foundation

extension Profile : Identifiable {
    func getSex() -> Sex? {
        if let sex = Sex(rawValue: self.sex) {
            return sex
        } else {
            return .none
        }
    }
}
