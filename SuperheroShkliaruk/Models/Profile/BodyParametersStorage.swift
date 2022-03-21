//
//  BodyParametersStorage.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import Foundation
import CoreData

class BodyParametersStorage {
    public static let sharedInstance = BodyParametersStorage()
    private let profileManager = ProfileManager.sharedInstance
    
    private let parameterTitles = ["Height",
                                   "Weight",
                                   "Neck",
                                   "Shoulders",
                                   "Left biceps",
                                   "Right biceps",
                                   "Left thigh",
                                   "Right thigh",
                                   "Left forearm",
                                   "Right forearm",
                                   "Chest",
                                   "Left lower leg",
                                   "Right lower leg",
                                   "Left ankle",
                                   "Right ankle"]
    
    private func createDefaultBodyParameters() -> [BodyParameter] {
        let context = ProfileManager.sharedInstance.mainContext
        let entity = NSEntityDescription.entity(forEntityName: "BodyParameter", in: context)
        
        let parameters: [BodyParameter] = parameterTitles.map { parameterTitle in
            let parameter = BodyParameter(entity: entity!, insertInto: context)
            parameter.title = parameterTitle
            parameter.isSelected = false
            return parameter
        }
        
        return parameters
    }
    
    public func fetchBodyParameters() -> [BodyParameter] {
        if let bodyParameters = profileManager.userProfile?.bodyParameters, bodyParameters.count > 0 {
            let parameters: [BodyParameter] = Array(_immutableCocoaArray: bodyParameters)
            return parameters
        } else {
            return createDefaultBodyParameters()
        }
    }
}
