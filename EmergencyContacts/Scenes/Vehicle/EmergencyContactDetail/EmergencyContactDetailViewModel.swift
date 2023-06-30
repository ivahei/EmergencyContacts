//
//  EmergencyContactDetailViewModel.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import Combine
import SwiftUI

enum DetailViewType {
    case edit(contact: EmergencyContact)
    case create
}

import Foundation
import Combine

final class EmergencyContactDetailViewModel: ObservableObject {
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var primaryPhone: String = .empty
    @Published var secondaryPhone: String = .empty
    @Published var relationship: String = "--"
    @Published var isButtonEnabled = false

    let relationships = ["--", "Assistant", "Boss", "Brother", "Sister"]

    var emergencyContactService: any EmergencySavable
    var type: DetailViewType

    init(type: DetailViewType = .create,
         emergencyContactService: any EmergencySavable) {
        self.type = type
        self.emergencyContactService = emergencyContactService

        if case .edit(let contact) = type {
            self.firstName = contact.firstName
            self.lastName = contact.lastName
            self.primaryPhone = contact.phoneNumber
            self.secondaryPhone = contact.secondaryPhoneNumber
            self.relationship = contact.relationship
        }

        let isEmptyPublisher = Publishers.CombineLatest3($firstName, $lastName, $primaryPhone)
            .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }
        
        isEmptyPublisher
            .assign(to: &$isButtonEnabled)
    }
}
