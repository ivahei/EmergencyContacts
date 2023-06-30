//
//  EmergencyContactRow.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 30.06.23.
//

import SwiftUI

struct EmergencyContactRow: View {
    @StateObject var contact: EmergencyContact
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                
                HStack {
                    Text(contact.firstName)
                        .padding(.top, 4)
                        .font(Font(CTFont(CTFontUIFontType.label, size: 19)))
                        .padding(.leading, 12)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    Spacer()
                }
                
                HStack {
                    Text(contact.phoneNumber)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 4)
                        .padding(.leading, 12)
                        .foregroundColor(Color(.lightGray))
                    Spacer()
                }
                Spacer()
            }
            ChevronArrow()
        }
        .background(.white)
        .cornerRadius(4)
        .shadow(color: .black.opacity(0.1), radius: 20)
        .padding(.horizontal, 20)
        .padding([.top, .trailing], 8)
        .contentShape(Rectangle())
    }
}

struct ChevronArrow: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .padding(.trailing, 25)
            .background(.clear)
            .foregroundColor(.black)
    }
}
