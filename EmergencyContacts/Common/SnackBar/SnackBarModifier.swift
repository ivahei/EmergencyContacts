//
//  SnackBarModifier.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct SnackBarModifier: ViewModifier {
    @Binding var snackBarData: SnackBarData?

    func body(content: Content) -> some View {
        ZStack {
            content

            VStack {
                Spacer()
                if let snackBarData = snackBarData {
                    SnackBar(snackBarData: .constant(snackBarData))
                        .opacity(snackBarData.isVisible ? 0.8 : 0)
                        .animation(.easeInOut, value: snackBarData.isVisible)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + snackBarData.dismissAfter) {
                                withAnimation {
                                    self.snackBarData?.isVisible = false
                                }
                                self.snackBarData?.reset() // Reset Snackbar data
                            }
                        }
                }
            }
            .padding()
        }
    }
}

extension View {
    func showSnackBar(_ snackBarData: Binding<SnackBarData?>) -> some View {
        self.modifier(SnackBarModifier(snackBarData: snackBarData))
    }
}
