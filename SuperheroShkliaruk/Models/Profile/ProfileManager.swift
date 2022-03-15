//
//  ProfileManager.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.02.2022.
//

import Foundation
import CoreData

class ProfileManager {
    static let sharedInstance = ProfileManager()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Profile")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    var userProfile: Profile?
    
    func createDefaultProfileWith(_ sex: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: mainContext)
        userProfile = Profile(entity: entity!, insertInto: mainContext)
        
        userProfile?.sex = sex
        userProfile?.name = ""
        saveProfile()
    }
    
    func saveProfile() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func retrieveSavedProfile() {
        let profileFetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
        
        do {
            let result = try mainContext.fetch(profileFetchRequest)
            userProfile = result.count > 0 ? result.first : nil
        } catch let nserror as NSError {
            fatalError("Error \(nserror), \(nserror.userInfo)")
        }
    }
    
}

