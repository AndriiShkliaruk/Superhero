//
//  BodyParameter+CoreDataProperties.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.03.2022.
//
//

import Foundation
import CoreData


extension BodyParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BodyParameter> {
        return NSFetchRequest<BodyParameter>(entityName: "BodyParameter")
    }

    @NSManaged public var isDisplayed: Bool
    @NSManaged public var isSelected: Bool
    @NSManaged public var title: String
    @NSManaged public var value: Int16
    @NSManaged public var units: String
    @NSManaged public var profile: Profile?

}

extension BodyParameter : Identifiable {

}
