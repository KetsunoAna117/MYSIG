//
//  EventListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    let eventList: [EventSIG]
    
    var body: some View {
        if eventList.isEmpty == false {
            List {
                ForEach(eventList, id: \.self) { anEvent in
                    EventCardView(event: anEvent)
                        .environmentObject(appStoreData)
                        .background(
                            NavigationLink(destination: {
                                EventDetails(selectedEvent: anEvent)
                                    .environmentObject(appStoreData)
                            }, label: {
                                Text("View Details")
                                    .foregroundColor(.blue)
                                    .font(.subheadline)
                            })
                        )
                }
            }
            .frame(maxHeight: .infinity)
            .listStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        EventListView(
            eventList: Utils().getAllEventFromListId(
                eventIdList: [1, 2, 3, 4],
                appStoreData: AppDataStore()
            )
        )
        .environmentObject(AppDataStore())
    }
    
}
