//
//  PersonController.swift
//  Week6Assessment
//
//  Created by Jon Corn on 2/14/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import Foundation

class PersonController {
    
    // MARK: - Properties
    static let shared = PersonController()
    var people = [Person]()
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD
    func create(personWithName name: String) {
        let person = Person(name: name)
        people.append(person)
        saveToPersistentStore()
    }
    
    func delete(person: Person) {
        if let index = people.firstIndex(of: person) {
            people.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    //  MARK: - JSONPersistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "personSaved.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(people)
            try data.write(to: fileURL())
        } catch let error {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let people = try decoder.decode([Person].self, from: data)
            self.people = people
        } catch let error {
            print(error)
        }
    }
}
