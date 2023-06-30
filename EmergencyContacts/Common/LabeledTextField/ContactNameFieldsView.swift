//
//  ContactNameFieldsView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

struct ContactNameFieldsView: View {
    @ObservedObject var viewModel: EmergencyContactDetailViewModel
    
    var body: some View {
        Group {
            LabeledTextField(label: "First Name", placeholder: "First Name", text: $viewModel.firstName)
            LabeledTextField(label: "Last Name", placeholder: "Last Name", text: $viewModel.lastName)
        }
    }
}
