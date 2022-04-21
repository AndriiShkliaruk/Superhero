//
//  BodyParametersStorage.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//

import Foundation
import CoreData
import OrderedCollections

class BodyParametersStorage {
    static let sharedInstance = BodyParametersStorage()
    private let profileManager = ProfileManager.sharedInstance
    
    private let rawParameters: OrderedDictionary =
    ["Height": "cm",
     "Weight": "kg",
     "Neck": "cm",
     "Shoulders": "cm",
     "Left biceps": "cm",
     "Right biceps": "cm",
     "Left thigh": "cm",
     "Right thigh": "cm",
     "Left forearm": "cm",
     "Right forearm": "cm",
     "Chest": "cm",
     "Left lower leg": "cm",
     "Right lower leg": "cm",
     "Left ankle": "cm",
     "Right ankle": "cm"]
    
    private func createDefaultBodyParameters() -> [BodyParameter] {
        let context = ProfileManager.sharedInstance.mainContext
        let entity = NSEntityDescription.entity(forEntityName: "BodyParameter", in: context)
        
        let parameters: [BodyParameter] = rawParameters.map { parameter in
            let bodyParameter = BodyParameter(entity: entity!, insertInto: context)
            bodyParameter.title = parameter.key
            bodyParameter.units = parameter.value
            bodyParameter.isSelected = false
            bodyParameter.isDisplayed = false
            bodyParameter.values = [Int16]()
            bodyParameter.dates = [Date]()
            return bodyParameter
        }
        
        return parameters
    }
    
    func fetchBodyParameters() -> [BodyParameter] {
        if let bodyParameters = profileManager.userProfile?.bodyParameters, bodyParameters.count > 0 {
            let parameters: [BodyParameter] = Array(_immutableCocoaArray: bodyParameters)
            return parameters
        } else {
            return createDefaultBodyParameters()
        }
    }
}
