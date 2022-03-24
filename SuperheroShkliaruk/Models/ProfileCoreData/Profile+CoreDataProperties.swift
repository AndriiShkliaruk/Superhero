//
//  Profile+CoreDataProperties.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 24.03.2022.
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
    @NSManaged public var avatar: Data?
    @NSManaged public var bodyParameters: NSOrderedSet?

}

// MARK: Generated accessors for bodyParameters
extension Profile {

    @objc(insertObject:inBodyParametersAtIndex:)
    @NSManaged public func insertIntoBodyParameters(_ value: BodyParameter, at idx: Int)

    @objc(removeObjectFromBodyParametersAtIndex:)
    @NSManaged public func removeFromBodyParameters(at idx: Int)

    @objc(insertBodyParameters:atIndexes:)
    @NSManaged public func insertIntoBodyParameters(_ values: [BodyParameter], at indexes: NSIndexSet)

    @objc(removeBodyParametersAtIndexes:)
    @NSManaged public func removeFromBodyParameters(at indexes: NSIndexSet)

    @objc(replaceObjectInBodyParametersAtIndex:withObject:)
    @NSManaged public func replaceBodyParameters(at idx: Int, with value: BodyParameter)

    @objc(replaceBodyParametersAtIndexes:withBodyParameters:)
    @NSManaged public func replaceBodyParameters(at indexes: NSIndexSet, with values: [BodyParameter])

    @objc(addBodyParametersObject:)
    @NSManaged public func addToBodyParameters(_ value: BodyParameter)

    @objc(removeBodyParametersObject:)
    @NSManaged public func removeFromBodyParameters(_ value: BodyParameter)

    @objc(addBodyParameters:)
    @NSManaged public func addToBodyParameters(_ values: NSOrderedSet)

    @objc(removeBodyParameters:)
    @NSManaged public func removeFromBodyParameters(_ values: NSOrderedSet)

}
