//
//  EmergencyContactDetailViewModel.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import Combine

enum DetailViewType {
    case edit(contact: EmergencyContact)
    case create
}

final class EmergencyContactDetailViewModel: ObservableObject {
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var primaryPhone: String = .empty
    @Published var secondaryPhone: String = .empty
    @Published var isButtonEnabled = false
    
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
        }

        let isEmptyPublisher = Publishers.CombineLatest($firstName, $lastName)
            .map { !$0.isEmpty && !$1.isEmpty }
        
        isEmptyPublisher
            .assign(to: &$isButtonEnabled)
    }
}
