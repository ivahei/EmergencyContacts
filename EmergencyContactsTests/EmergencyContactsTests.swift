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
        let updatedContact = mockService.contactList[0]
        emergencyContactService.update(contact: updatedContact)
        XCTAssertEqual(emergencyContactService.contactList[0].id, mockService.contactList[0].id)
    }

    func testSaveContact() {
        let newContact = mockService.contactList[0]
        emergencyContactService.save(contacts: [newContact])
        XCTAssertEqual(emergencyContactService.contactList[0].id, mockService.contactList[0].id)
    }

    func testRemoveContact() {
        let contactToRemove = mockService.contactList[0]
        emergencyContactService.remove(contact: contactToRemove)
        XCTAssertFalse(emergencyContactService.contactList.contains(where: { $0.id == contactToRemove.id }))
    }
}
