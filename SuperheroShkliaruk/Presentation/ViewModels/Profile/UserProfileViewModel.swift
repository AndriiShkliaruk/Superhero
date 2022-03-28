//
//  UserProfileViewModel.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 25.03.2022.
//

import Foundation

struct UserProfileViewModel {
    var name: String
    var avatar: Data?
    var parameters: [ParameterViewModel]
    
    init(_ model: Profile, _ bodyParameters: [ParameterViewModel]) {
        name = model.name ?? ""
        avatar = model.avatar
        parameters = bodyParameters
    }
}

extension UserProfileViewModel: Equatable {
    static func == (lhs: UserProfileViewModel, rhs: UserProfileViewModel) -> Bool {
        guard lhs.name == rhs.name else { return false }
        guard lhs.avatar == rhs.avatar else { return false }
        guard lhs.parameters == rhs.parameters else { return false }
        return true
    }
}
