//
//  ContactPhoneFieldsView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

struct ContactPhoneFieldsView: View {
    @ObservedObject var viewModel: EmergencyContactDetailViewModel
    
    var body: some View {
        Group {
            LabeledTextField(label: "Primary Phone", placeholder: "(000) 000-0000", text: $viewModel.primaryPhone, keyboardType: .numberPad)
            LabeledTextField(label: "Secondary Phone (optional)", placeholder: "(000) 000-0000", text: $viewModel.secondaryPhone, keyboardType: .numberPad)
        }
    }
}
