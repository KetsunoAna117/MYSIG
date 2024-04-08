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
        if let currentActiveUser = appStoreData.currentActiveUser{
            if eventList.isEmpty == false {
                VStack {
                    ForEach(eventList, id: \.self) { anEvent in
                        NavigationLink(destination: {
                            EventDetails(selectedEvent: anEvent, currentActiveUser: currentActiveUser)
                                .environmentObject(appStoreData)
                        }, label: {
                            EventCardView(event: anEvent)
                        })
                    }
                }
            }
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
