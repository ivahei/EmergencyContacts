//
//  ContentView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var emergencyContactService = EmergencyContactService()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            VehicleView(viewModel: VehicleViewModel(emergencyContactService: emergencyContactService))
                .tabItem {
                    Image(systemName: "car")
                    Text("Vehicle")
                }

            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }

            SupportView()
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Support")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(emergencyContactService)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
