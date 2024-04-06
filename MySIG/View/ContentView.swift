//
//  ContentView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 02/04/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @State private var tabSelection: Tab = .bookedEvent
        @State private var user = User(id: 1,
                                      email: "johndoe@example.com",
                                      password: "password123",
                                      name: "John Doe",
                                      phoneNumber: "+1234567890",
                                      cohort: 1,
                                      session: "Morning",
                                      joinedSigId: [],
                                      bookedEventId: [],
                                      notificationId: [])

        
            
        
    
    
    enum Tab {
        case bookedEvent
        case explore
        case profile
    }
    
    var body: some View {
        NavigationStack {
            if(appDataStore.currentActiveUser == nil){
                LoginView()
            }
            else{
                TabView(selection: $tabSelection, content: {
                    BookedEventView()
                        .environmentObject(appDataStore)
                        .tag(Tab.bookedEvent)
                        .tabItem {
                            Label("Booked Event", systemImage: "pencil.and.list.clipboard")
                        }
                        .navigationTitle("Booked Event")
                    ExploreView()
                        .environmentObject(appDataStore)
                        .tag(Tab.explore)
                        .tabItem {
                            Label("Explore", systemImage: "magnifyingglass")
                        }
                    ProfileView()
                        .environmentObject(appDataStore)
                        .tag(Tab.profile)
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                })
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppDataStore())
        
}
