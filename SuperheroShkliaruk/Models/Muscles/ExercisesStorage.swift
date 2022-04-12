//
//  ExercisesStorage.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 08.04.2022.
//

import Foundation

struct ExercisesStorage {
    func fetchExercisesByMyscleTypes() -> [MuscleGroup] {
        let fileData = readLocalFile(forName: "Exercises")
        let results: [MuscleGroup] = parse(jsonData: fileData)
        return results
    }
    
    private func parse<T: Decodable>(jsonData: Data) -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            fatalError("Decode error")
        }
    }
    
    private func readLocalFile(forName name: String) -> Data {
        do {
            guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else  { fatalError("Can't convert file contents") }
            return jsonData
        } catch {
            fatalError("Can't read file")
        }
    }
}
