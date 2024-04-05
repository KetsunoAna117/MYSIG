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
                    if tabSelection == Tab.event {
                        EventListView(searchedText: $searchText)
                            .environmentObject(appDataStore)
                    } else if tabSelection == Tab.sig {
                        SIGListView(searchedText: $searchText)
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
