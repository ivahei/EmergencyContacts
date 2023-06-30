//
//  VehicleView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct VehicleView: View {
    @StateObject var viewModel: VehicleViewModel
    @State var localContactList: [EmergencyContact]
    @EnvironmentObject var emergencyContactService: EmergencyContactService

    init(viewModel: VehicleViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.localContactList = viewModel.emergencyContactList
    }
    
    var activeButtonColor = Color(red: 64/255, green: 160/255, blue: 218/255)
    
    var body: some View {
        
        // Mock Data for testing
        return NavigationView {
            VStack {
                Spacer(minLength: 40)
                EmergencyContactHeader()
                    .padding([.leading, .trailing], 20)
                
                ScrollView {
                    VStack {
                        ForEach(localContactList) { contact in
                            let viewModel = EmergencyContactDetailViewModel(type: .edit(contact: contact),
                                                                            emergencyContactService: viewModel.emergencyContactService)
                            NavigationLink {
                                // Opened Details screen in Edit mode
                                EmergencyContactDetailView(viewModel: viewModel)
                                    .navigationTitle("Emergency Contacts")
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                EmergencyContactRow(contact: contact)
                            }
                            Spacer().frame(maxHeight: 20)
                        }
                    }
                    .padding(.top, 24)
                }
                
                NavigationLink {
                    // Opened Details screen in Create mode
                    EmergencyContactDetailView(viewModel: EmergencyContactDetailViewModel(type: .create,
                                                                                          emergencyContactService: viewModel.emergencyContactService))
                    .navigationTitle("Emergency Contacts")
                    .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("+ ADD A CONTACT")
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(self.activeButtonColor)
                        .cornerRadius(25)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .shadow(radius: 25)
                }
                .padding(.bottom, 30)
            }
            .showSnackBar($viewModel.snackBarData)
            .onAppear {
                viewModel.refreshData()
            }
            .onReceive(viewModel.$emergencyContactList) {
                localContactList = $0
            }
        }
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleView(viewModel: VehicleViewModel(emergencyContactService: FakeEmergencyContactService()))
    }
}
