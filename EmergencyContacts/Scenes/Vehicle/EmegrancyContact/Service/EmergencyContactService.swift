//
//  EmergencyContactService.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI
import Combine

protocol EmergencySavable: ObservableObject {
    var contactList: [EmergencyContact] { get }
    func update(contact: EmergencyContact)
    func save(contacts: [EmergencyContact])
    func remove(contact: EmergencyContact)
}


final class EmergencyContactService: ObservableObject, EmergencySavable {
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
