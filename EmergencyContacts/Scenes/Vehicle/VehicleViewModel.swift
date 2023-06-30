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
