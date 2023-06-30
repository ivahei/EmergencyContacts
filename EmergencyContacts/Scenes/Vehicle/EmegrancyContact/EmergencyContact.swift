//
//  EmergencyContact.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

final class EmergencyContact: ObservableObject, Codable, Identifiable, Equatable {
    var id = UUID()
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var phoneNumber: String = .empty
    @Published var secondaryPhoneNumber: String = .empty
    @Published var relationship: String = "--"

    static func == (lhs: EmergencyContact, rhs: EmergencyContact) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case phoneNumber
        case lastName
        case secondaryPhoneNumber
        case relationship
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .name)
        lastName = try container.decode(String.self, forKey: .lastName)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        secondaryPhoneNumber = try container.decode(String.self, forKey: .secondaryPhoneNumber)
        relationship = try container.decode(String.self, forKey: .relationship)
    }

    init(id: UUID = UUID(), firstName: String, lastName: String, phoneNumber: String, secondaryPhoneNumber: String, relationship: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.secondaryPhoneNumber = secondaryPhoneNumber
        self.relationship = relationship
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(secondaryPhoneNumber, forKey: .secondaryPhoneNumber)
        try container.encode(relationship, forKey: .relationship)
    }
}
