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
    
    enum Tab {
        case bookedEvent
        case explore
        case profile
    }
    
    var body: some View {
        if(appDataStore.currentActiveUser == nil){
            LoginView()
        }
        else{
            if let currentActiveUser = appDataStore.currentActiveUser {
                TabView(selection: $tabSelection, content: {
                    BookedEventView()
                        .environmentObject(appDataStore)
                        .navigationBarTitleDisplayMode(.inline)
                        .tag(Tab.bookedEvent)
                        .tabItem {
                            Label("Booked Event", systemImage: "pencil.and.list.clipboard")
                        }
                    ExploreView()
                        .environmentObject(appDataStore)
                        .tag(Tab.explore)
                        .tabItem {
                            Label("Explore", systemImage: "magnifyingglass")
                        }
                    //                    .toolbar {
                    //                        ToolbarItem(placement: .navigation) {
                    //                            Text("Explore")
                    //                                .font(.largeTitle)
                    //                                .fontWeight(.bold)
                    //                                .padding(.top, 80)
                    //                        }
                    //                    }
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
