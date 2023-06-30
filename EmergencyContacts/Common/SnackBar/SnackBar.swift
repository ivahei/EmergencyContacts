//
//  SnackBar.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct SnackBar: View {
    @Binding var snackBarData: SnackBarData

    var body: some View {
        HStack {
            Text(snackBarData.message)
                .font(.system(size: 14))
            Spacer()
            if let icon = snackBarData.icon {
                icon
            }
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(12)
        .opacity(snackBarData.isVisible ? 1 : 0)
        .offset(x: 0, y: snackBarData.isVisible ? 0 : 50)
        .padding(.bottom, 10)
        .animation(.easeInOut, value: snackBarData.isVisible)
    }
}
