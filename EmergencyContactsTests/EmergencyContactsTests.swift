//
//  EmergencyContactsTests.swift
//  EmergencyContactsTests
//
//  Created by Vahe Abazyan on 29.06.23.
//

import XCTest
@testable import EmergencyContacts

final class EmergencyContactsTests: XCTestCase {
    var emergencyContactService: EmergencyContactService!
    var mockService: FakeEmergencyContactService!

    override func setUp() {
        super.setUp()
        mockService = FakeEmergencyContactService()
        emergencyContactService = EmergencyContactService()
        emergencyContactService.contactList = mockService.contactList
    }
    
    override func tearDown() {
        emergencyContactService = nil
        mockService = nil
        super.tearDown()
    }

    func testUpdateContact() {
        let updatedContact = EmergencyContact(id: mockService.contactList[0].id,
                                              firstName: "Updated",
                                              lastName: "Name",
                                              phoneNumber: "1234567890",
                                              secondaryPhoneNumber: "0987654321",
                                              relationship: "Friend")
        emergencyContactService.update(contact: updatedContact)
        XCTAssertEqual(emergencyContactService.contactList[0].firstName, "Updated")
    }

    func testSaveContact() {
        let newContact = EmergencyContact(firstName: "New",
                                          lastName: "Contact",
                                          phoneNumber: "1122334455",
                                          secondaryPhoneNumber: "9988776655",
                                          relationship: "Cousin")
        emergencyContactService.save(contacts: [newContact])
        XCTAssertEqual(emergencyContactService.contactList.last?.firstName, "New")
    }

    func testRemoveContact() {
        let contactToRemove = mockService.contactList[0]
        emergencyContactService.remove(contact: contactToRemove)
        XCTAssertFalse(emergencyContactService.contactList.contains(where: { $0.id == contactToRemove.id }))
    }
}
