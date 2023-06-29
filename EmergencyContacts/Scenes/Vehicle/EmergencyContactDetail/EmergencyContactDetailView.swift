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
    
    var inactiveButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255).opacity(0.25)
    var activeButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255)
    
    var body: some View {
        VStack {
            HStack {
                Text("First Name")
                Spacer()
            }
            TextField("First Name", text: $viewModel.firstName)
                .padding(10)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(radius: 5)
                .keyboardType(.namePhonePad)
            
            HStack {
                Text("Last Name")
                Spacer()
            }
            TextField("Last Name", text: $viewModel.lastName)
                .padding(10)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(radius: 5)
                .keyboardType(.namePhonePad)
            
            HStack {
                Text("Primary Phone")
                Spacer()
            }
            TextField(
                "(000) 000-0000", text: $viewModel.primaryPhone)
            .padding(10)
            .background(Color(.white))
            .cornerRadius(5)
            .shadow(radius: 5)
            .keyboardType(.numberPad)
            
            HStack {
                Text("Secondary Phone (optional)")
                Spacer()
            }
            TextField("(000) 000-0000", text: $viewModel.secondaryPhone)
                .padding(10)
                .background(Color(.white))
                .cornerRadius(5)
                .shadow(radius: 5)
                .keyboardType(.numberPad)
            
            Spacer()
            
            VStack {
                Button(action: {
                    switch viewModel.type {
                    case .create:
                        viewModel.emergencyContactService.save(
                            contacts: [
                                EmergencyContact(firstName: viewModel.firstName,
                                                 lastName: viewModel.lastName,
                                                 phoneNumber: viewModel.primaryPhone,
                                                 secondaryPhoneNumber: viewModel.secondaryPhone)]
                        )
                    case .edit(let contact):
                        contact.firstName = viewModel.firstName
                        contact.lastName = viewModel.lastName
                        contact.phoneNumber = viewModel.primaryPhone
                        contact.secondaryPhoneNumber = viewModel.secondaryPhone
                        viewModel.emergencyContactService.update(contact: contact)
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(viewModel.isButtonEnabled ? self.activeButtonColor : self.inactiveButtonColor)
                .disabled(!viewModel.isButtonEnabled)
                .cornerRadius(25)
                .shadow(radius: 5)
                
                if case .edit(let contact) = viewModel.type {
                    Button(action: {
                        viewModel.emergencyContactService.remove(contact: contact)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Delete Contact")
                            .foregroundColor(.blue)
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .background(Color.clear)
                    .shadow(radius: 5)
                }
            }
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
