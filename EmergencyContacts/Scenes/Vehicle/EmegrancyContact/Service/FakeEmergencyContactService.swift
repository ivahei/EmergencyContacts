//
//  FakeEmergencyContactService.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

// Mock Data for testing
final class FakeEmergencyContactService: EmergencySavable {
    var contactList: [EmergencyContact] = []
    func update(contact: EmergencyContact) {}
    func save(contacts: [EmergencyContact]) {}
    func remove(contact: EmergencyContact) {}

    init() {
        let contact_1 = EmergencyContact(firstName: "John",
                                         lastName: "Smith",
                                         phoneNumber: "055555555",
                                         secondaryPhoneNumber: "077777777",
                                         relationship: "Brother")
        let contact_2 = EmergencyContact(firstName: "Ada",
                                         lastName: "Wong",
                                         phoneNumber: "011012012",
                                         secondaryPhoneNumber: "084097892",
                                         relationship: "Sister")
        let contact_3 = EmergencyContact(firstName: "Alex",
                                         lastName: "Sandro",
                                         phoneNumber: "093212321",
                                         secondaryPhoneNumber: "098890021",
                                         relationship: "Boss")
        let contact_4 = EmergencyContact(firstName: "Leon",
                                         lastName: "Young",
                                         phoneNumber: "091381098",
                                         secondaryPhoneNumber: "098412991",
                                         relationship: "Brother")

        contactList = [
            contact_1,
            contact_2,
            contact_3,
            contact_4
        ]
    }
}
