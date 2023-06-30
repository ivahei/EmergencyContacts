//
//  EmergencyContactHeader.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

struct EmergencyContactHeader: View {
    var body: some View {
        Text("List up to four people we can call upon your request in the event of an emergency.")
            .foregroundColor(.black)
            .lineLimit(nil)
            .padding(30)
            .multilineTextAlignment(.leading)
            .background(.white)
            .cornerRadius(4)
            .shadow(color: .black.opacity(0.2), radius: 30)
    }
}
