//
//  ExploreView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @State private var tabSelection: Tab = .event
    @State var searchText: String = ""
    
    enum Tab {
        case event
        case sig
    }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Constants.Orange)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.white)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Constants.Purple)], for: .normal)
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                Picker(
                    selection: $tabSelection,
                    content: {
                        Text("Events").tag(Tab.event)
                        Text("SIGs").tag(Tab.sig)
                    },
                    label: {
                        Text("Select what to explore")
                    })
                .frame(width: 200)
                .pickerStyle(.segmented)
                
                VStack {
                    switch tabSelection {
                    case .event:
                        if let user = appDataStore.currentActiveUser {
                            let eventList = Utils().getEventListWithoutTheUser(
                                userId: user.id,
                                appStoreData: appDataStore)
                            ExploreEventView(searchedText: $searchText, eventList: eventList)
                                .environmentObject(appDataStore)
                        }
                    case .sig:
                        let sigList = Utils().getAllSIG(appStoreData: appDataStore)
                        ExploreSIGView(searchedText: $searchText, sigList: sigList)
                            .environmentObject(appDataStore)
                    }
                }
                .padding(.top, 10)
                
            }
            .navigationTitle("Explore")
            .searchable(text: $searchText, placement: .automatic)
        }
        
    }
}

#Preview {
    ExploreView()
        .environmentObject(AppDataStore())
}
