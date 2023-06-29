//
//  ContentView.swift
//  EmergencyContacts
//
//  Created by Vahe Abazyan on 29.06.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            VehicleView(viewModel: VehicleViewModel(emergencyContactService: EmergencyContactService()))
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
