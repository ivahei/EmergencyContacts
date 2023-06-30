//
//  LabeledTextField.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

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
