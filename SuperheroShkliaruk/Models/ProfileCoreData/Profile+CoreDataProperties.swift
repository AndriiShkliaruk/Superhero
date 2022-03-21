//
//  Profile+CoreDataProperties.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.03.2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var sex: String
    @NSManaged public var bodyParameters: NSOrderedSet?

}

// MARK: Generated accessors for bodyParameters
extension Profile {

    @objc(addBodyParametersObject:)
    @NSManaged public func addToBodyParameters(_ value: BodyParameter)

    @objc(removeBodyParametersObject:)
    @NSManaged public func removeFromBodyParameters(_ value: BodyParameter)

    @objc(addBodyParameters:)
    @NSManaged public func addToBodyParameters(_ values: NSSet)

    @objc(removeBodyParameters:)
    @NSManaged public func removeFromBodyParameters(_ values: NSSet)

}

