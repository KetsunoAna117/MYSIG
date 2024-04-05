//
//  EventListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 04/04/24.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @Binding var searchedText: String

    var body: some View {
        List {
            if let user = appDataStore.currentActiveUser {
                let eventList = Utils().getEventListWithoutTheUser(
                    user: user,
                    appStoreData: appDataStore)
                ForEach(eventList, id: \.self) { event in
                    EventCardView(event: event)
                        .listRowInsets(EdgeInsets())
                        .environmentObject(appDataStore)
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(10)
    }
}

#Preview {
    EventListView(searchedText: .constant("Badminton"))
        .environmentObject(AppDataStore())
}
