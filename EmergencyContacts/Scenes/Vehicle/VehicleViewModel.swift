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
    @Published var snackBarData: SnackBarData?
    init(emergencyContactService: any EmergencySavable) {
        self.emergencyContactService = emergencyContactService
        self.emergencyContactList = emergencyContactService.contactList

        // Listen for changes in EmergencyContactService
        if let service = emergencyContactService as? EmergencyContactService {
            service.snackBarPublisher
                .assign(to: &$snackBarData)
        }
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
    let snackBarPublisher = PassthroughSubject<SnackBarData?, Never>()
    
    func update(contact: EmergencyContact) {
        if let index = contactList.firstIndex(where: { $0.id == contact.id }) {
            contactList[index] = contact
            snackBarPublisher.send(SnackBarData(message: "Emergency contact updated successfully",
                                                icon: Image(systemName: "pencil"),
                                                isVisible: true,
                                                dismissAfter: 2))
        }
    }
    
    func save(contacts: [EmergencyContact]) {
        contactList.append(contentsOf: contacts)
        snackBarPublisher.send(SnackBarData(message: "Emergency contact created successfully",
                                            icon: Image(systemName: "plus"),
                                            isVisible: true,
                                            dismissAfter: 2))
    }
    
    func remove(contact: EmergencyContact) {
        if let index = contactList.firstIndex(where: { $0.id == contact.id }) {
            contactList.remove(at: index)
            snackBarPublisher.send(SnackBarData(message: "Emergency contact deleted successfully",
                                                icon: Image(systemName: "trash"),
                                                isVisible: true, 
                                                dismissAfter: 2))
        }
    }
}

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
