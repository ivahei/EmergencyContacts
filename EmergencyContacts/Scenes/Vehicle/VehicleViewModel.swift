//
//  VehicleViewModel.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI
import Combine

final class VehicleViewModel: ObservableObject {
    @Published var emergencyContactList: [EmergencyContact]
    private(set) var emergencyContactService: any EmergencySavable

    init(emergencyContactService: any EmergencySavable) {
        self.emergencyContactService = emergencyContactService
        self.emergencyContactList = emergencyContactService.contactList
    }

    func refreshData() {
        self.emergencyContactList = emergencyContactService.contactList
    }
}

protocol EmergencySavable: ObservableObject {
    var contactList: [EmergencyContact] { get }
    func update(contact: EmergencyContact)
    func save(contacts: [EmergencyContact])
    func remove(contact: EmergencyContact)
}


class EmergencyContactService: ObservableObject, EmergencySavable {
    @AppStorage("emergencyContactKey") var contactList = [EmergencyContact]()

    func update(contact: EmergencyContact) {
        if let index = contactList.firstIndex(where: { $0.id == contact.id }) {
            contactList[index] = contact
        }
    }

    func save(contacts: [EmergencyContact]) {
        contactList.append(contentsOf: contacts)
    }
    
    func remove(contact: EmergencyContact) {
        if let index = contactList.firstIndex(where: { $0.id == contact.id }) {
            contactList.remove(at: index)
        }
    }
}

// Mock Data for testing
class FakeEmergencyContactService: EmergencySavable {
    var contactList: [EmergencyContact] = []
    func update(contact: EmergencyContact) {}
    func save(contacts: [EmergencyContact]) {}
    func remove(contact: EmergencyContact) {}

    init() {
        let contact_1 = EmergencyContact(firstName: "John",
                                         lastName: "Smith",
                                         phoneNumber: "055555555",
                                         secondaryPhoneNumber: "077777777")
        let contact_2 = EmergencyContact(firstName: "Ada",
                                         lastName: "Wong",
                                         phoneNumber: "011012012",
                                         secondaryPhoneNumber: "084097892")
        let contact_3 = EmergencyContact(firstName: "Alex",
                                         lastName: "Sandro",
                                         phoneNumber: "093212321",
                                         secondaryPhoneNumber: "098890021")
        let contact_4 = EmergencyContact(firstName: "Leon",
                                         lastName: "Young",
                                         phoneNumber: "091381098",
                                         secondaryPhoneNumber: "098412991")

        contactList = [
            contact_1,
            contact_2,
            contact_3,
            contact_4
        ]
    }
}
