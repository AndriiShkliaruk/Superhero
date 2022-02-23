//
//  Profile+CoreDataProperties.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 21.02.2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var sex: String

}

extension Profile : Identifiable {
    func getSex() -> Sex? {
        if let sex = Sex(rawValue: self.sex) {
            return sex
        } else {
            return .none
        }
    }
}
