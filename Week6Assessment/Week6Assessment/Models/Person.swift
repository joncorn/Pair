//
//  Person.swift
//  Week6Assessment
//
//  Created by Jon Corn on 2/14/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import Foundation

class Person: Codable {
    
    // PROPERTIES
    // since pairs could potentially have the same name using timestamp or a UUID would prevent errors when equating
    // UUID makes more sense in this case
    var name: String
    var id: String
    
    // INITIALIZER
    init(name: String, id: String = UUID().uuidString) {
        self.name = name
        self.id = id
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
