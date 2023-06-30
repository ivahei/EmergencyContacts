//
//  SnackBarData.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct SnackBarData {
    var message: String
    var icon: Image?
    var isVisible: Bool
    var dismissAfter: Double = 2.0
    
    mutating func reset() {
        message = .empty
        icon = nil
        isVisible = false
    }
}
