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
        NavigationView {
            VStack {
                addHeader()
                addEmergencyContactList()
                addAddContactButton()
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

    @ViewBuilder
    func addHeader() -> some View {
        Spacer(minLength: 40)
        EmergencyContactHeader()
            .padding([.leading, .trailing], 20)
    }

    @ViewBuilder
    func addEmergencyContactList() -> some View {
        ScrollView {
            VStack() {
                ForEach(localContactList) { contact in
                    NavigationLink(destination: EmergencyContactDetailView(viewModel: getContactDetailViewModel(contact: contact))) {
                        EmergencyContactRow(contact: contact)
                    }
                }
            }
            .padding(.top, 24)
        }
    }

    @ViewBuilder
    func addAddContactButton() -> some View {
        NavigationLink(destination: EmergencyContactDetailView(viewModel: getContactDetailViewModel(type: .create))) {
            Text("+ ADD A CONTACT")
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(self.activeButtonColor)
                .cornerRadius(25)
                .padding(.horizontal, 20)
                .shadow(radius: 25)
        }
        .padding(.bottom, 30)
    }

    // Helper functions to create view model
    func getContactDetailViewModel(contact: EmergencyContact) -> EmergencyContactDetailViewModel {
        return EmergencyContactDetailViewModel(type: .edit(contact: contact), emergencyContactService: viewModel.emergencyContactService)
    }

    func getContactDetailViewModel(type: DetailViewType) -> EmergencyContactDetailViewModel {
        return EmergencyContactDetailViewModel(type: type, emergencyContactService: viewModel.emergencyContactService)
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleView(viewModel: VehicleViewModel(emergencyContactService: FakeEmergencyContactService()))
    }
}
