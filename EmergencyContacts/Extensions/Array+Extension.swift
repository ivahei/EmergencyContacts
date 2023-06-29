//
//  Array+Extension.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import Foundation

public extension Array where Element: Equatable {
    var unique: [Element] {
         var uniqueValues: [Element] = []
         forEach { item in
             guard !uniqueValues.contains(item) else { return }
             uniqueValues.append(item)
         }
         return uniqueValues
     }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
