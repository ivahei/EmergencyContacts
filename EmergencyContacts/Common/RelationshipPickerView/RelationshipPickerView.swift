//
//  RelationshipPickerView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

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
