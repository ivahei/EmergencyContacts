//
//  EmergencyContactDetailView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct EmergencyContactDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: EmergencyContactDetailViewModel
    @State var showingDeleteAlert = false

    var body: some View {
        VStack {
            ContactNameFieldsView(viewModel: viewModel)
            ContactPhoneFieldsView(viewModel: viewModel)
            RelationshipPickerView(viewModel: viewModel)
            Spacer()
            ActionButtonsView(viewModel: viewModel, presentationMode: presentationMode)
        }
        .background(Color.clear)
        .padding(30)
    }
}

struct EmergencyContactListView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyContactDetailView(viewModel: EmergencyContactDetailViewModel(type: .create, emergencyContactService: FakeEmergencyContactService()))
    }
}
