//
//  ActionButtonsView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

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
