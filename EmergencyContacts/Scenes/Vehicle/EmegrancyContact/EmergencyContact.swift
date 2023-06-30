//
//  EmergencyContact.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

final class EmergencyContact: ObservableObject, Codable, Identifiable, Equatable {
    var id = UUID()
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var phoneNumber: String = .empty
    @Published var secondaryPhoneNumber: String = .empty
    @Published var relationship: String = "--"

    static func == (lhs: EmergencyContact, rhs: EmergencyContact) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case phoneNumber
        case lastName
        case secondaryPhoneNumber
        case relationship
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .name)
        lastName = try container.decode(String.self, forKey: .lastName)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        secondaryPhoneNumber = try container.decode(String.self, forKey: .secondaryPhoneNumber)
        relationship = try container.decode(String.self, forKey: .relationship)
    }

    init(id: UUID = UUID(), firstName: String, lastName: String, phoneNumber: String, secondaryPhoneNumber: String, relationship: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.secondaryPhoneNumber = secondaryPhoneNumber
        self.relationship = relationship
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(secondaryPhoneNumber, forKey: .secondaryPhoneNumber)
        try container.encode(relationship, forKey: .relationship)
    }
}

struct EmergencyContactHeader: View {
    var body: some View {
        Text("List up to four people we can call upon your request in the event of an emergency.")
            .foregroundColor(Color.black)
            .lineLimit(nil)
            .padding(30)
            .multilineTextAlignment(.leading)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: .black.opacity(0.2), radius: 30)
    }
}

struct ChevronArrow: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .padding(.trailing, 25)
            .background(Color.clear)
            .foregroundColor(Color.black)
    }
}

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
                        .foregroundColor(Color(.black))
                    Spacer()
                }
                
                HStack {
                    Text(contact.phoneNumber)
                        .multilineTextAlignment(.leading)
                        .padding([.bottom], 4)
                        .padding(.leading, 12)
                        .foregroundColor(Color(.lightGray))
                    Spacer()
                }
                Spacer()
            }
            ChevronArrow()
        }
        .background(Color.white)
        .cornerRadius(4)
        .shadow(color: .black.opacity(0.1), radius: 20)
        .padding( [.leading, .trailing], 20)
        .padding( [.top, .trailing], 8)
        .contentShape(Rectangle())
    }
}
