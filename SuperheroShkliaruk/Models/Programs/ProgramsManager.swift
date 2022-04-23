//
//  ProgramsManager.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 19.04.2022.
//

import Foundation

class ProgramsManager {
    static let sharedInstance = ProgramsManager()
    private var filePath: URL {
        getDirectoryPath().appendingPathComponent("Programs")
    }
    private var programs: [Program] = []
    
    func fetchPrograms() -> [Program] {
        var programs = [Program]()
        do {
            let data = try Data(contentsOf: filePath)
            guard let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data else { return programs }
            programs = try PropertyListDecoder().decode([Program].self, from: unarchivedData)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        self.programs = programs
        return programs
    }
    
    func update(_ oldProgram: Program, with newProgram: Program) {
        guard let index = programs.firstIndex(of: oldProgram) else { return }
        programs[index] = newProgram
        saveToFile(programs)
    }
    
    func save(_ newProgram: Program) {
        programs.append(newProgram)
        saveToFile(programs)
    }
    
    func delete(at index: Int) {
        programs.remove(at: index)
        saveToFile(programs)
    }
    
    private func saveToFile(_ programs: [Program]) {
        do {
            let encodedPrograms = try PropertyListEncoder().encode(programs)
            let data = try NSKeyedArchiver.archivedData(withRootObject: encodedPrograms, requiringSecureCoding: false)
            try data.write(to: filePath)
        } catch {
            print("Error: \(error.localizedDescription)")
            print(String(describing: error))
        }
    }
    
    private func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
}
