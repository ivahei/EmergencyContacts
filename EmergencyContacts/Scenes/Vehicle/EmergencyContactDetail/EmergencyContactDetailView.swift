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

    var inactiveButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255).opacity(0.25)
    var activeButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255)
    
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

struct ContactNameFieldsView: View {
    @ObservedObject var viewModel: EmergencyContactDetailViewModel
    
    var body: some View {
        Group {
            LabeledTextField(label: "First Name", placeholder: "First Name", text: $viewModel.firstName)
            LabeledTextField(label: "Last Name", placeholder: "Last Name", text: $viewModel.lastName)
        }
    }
}

struct ContactPhoneFieldsView: View {
    @ObservedObject var viewModel: EmergencyContactDetailViewModel
    
    var body: some View {
        Group {
            LabeledTextField(label: "Primary Phone", placeholder: "(000) 000-0000", text: $viewModel.primaryPhone, keyboardType: .numberPad)
            LabeledTextField(label: "Secondary Phone (optional)", placeholder: "(000) 000-0000", text: $viewModel.secondaryPhone, keyboardType: .numberPad)
        }
    }
}

struct RelationshipPickerView: View {
    @ObservedObject var viewModel: EmergencyContactDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Relationship")
                .multilineTextAlignment(.leading)

            Picker(selection: $viewModel.relationship, label: Text("Relationship")) {
                ForEach(viewModel.relationships, id: \.self) {
                    Text($0)
                }
            }
            .padding(3)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(5)
            .shadow(radius: 5)
            .accentColor(.black)
        }
    }
}

struct ActionButtonsView: View {
    @ObservedObject var viewModel: EmergencyContactDetailViewModel
    
    @Binding var presentationMode: PresentationMode
    @State var showingDeleteAlert = false

    var inactiveButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255).opacity(0.25)
    var activeButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255)
    
    var body: some View {
        VStack {
            Button(action: {
                saveAction()
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .background(viewModel.isButtonEnabled ? activeButtonColor : inactiveButtonColor)
            .disabled(!viewModel.isButtonEnabled)
            .cornerRadius(25)
            .shadow(radius: 5)
            
            if case .edit(let contact) = viewModel.type {
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Text("Delete Contact")
                        .foregroundColor(.blue)
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(.clear)
                .shadow(radius: 5)
                .alert(isPresented: $showingDeleteAlert) {
                    Alert(title: Text("Delete Contact?"),
                          message: Text("Are you sure you want to remove this contact?"),
                          primaryButton: .destructive(Text("Yes")) {
                        deleteAction(for: contact)
                    },
                          secondaryButton: .cancel(Text("No")))
                }
            }
        }
    }
    
    private func saveAction() {
        switch viewModel.type {
        case .create:
            viewModel.emergencyContactService.save(
                contacts: [
                    EmergencyContact(firstName: viewModel.firstName,
                                     lastName: viewModel.lastName,
                                     phoneNumber: viewModel.primaryPhone,
                                     secondaryPhoneNumber: viewModel.secondaryPhone,
                                     relationship: viewModel.relationship)]
            )
        case .edit(let contact):
            contact.firstName = viewModel.firstName
            contact.lastName = viewModel.lastName
            contact.phoneNumber = viewModel.primaryPhone
            contact.secondaryPhoneNumber = viewModel.secondaryPhone
            contact.relationship = viewModel.relationship
            viewModel.emergencyContactService.update(contact: contact)
        }
        dismissView()
    }
    
    private func deleteAction(for contact: EmergencyContact) {
        viewModel.emergencyContactService.remove(contact: contact)
        dismissView()
    }
    
    private func dismissView() {
        Task {
            presentationMode.dismiss()
        }
    }
}

struct LabeledTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
            }
            TextField(placeholder, text: $text)
                .padding(10)
                .background(.white)
                .cornerRadius(5)
                .shadow(radius: 5)
                .keyboardType(keyboardType)
        }
    }
}

struct EmergencyContactListView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyContactDetailView(viewModel: EmergencyContactDetailViewModel(type: .create, emergencyContactService: FakeEmergencyContactService()))
    }
}
