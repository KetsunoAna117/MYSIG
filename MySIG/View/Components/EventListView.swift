//
//  EventListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct EventListView: View {
    let eventList: [EventSIG]
    
    var body: some View {
        if eventList.isEmpty == false {
            List {
                ForEach(eventList, id: \.self) { anEvent in
                    EventCardView(event: anEvent)
                        .environmentObject(AppDataStore())
                }
                //            .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .listRowSpacing(10)
        }
    }
}

#Preview {
    EventListView(
        eventList: Utils().getAllEventFromListId(
            eventIdList: [1, 2, 3, 4],
            appStoreData: AppDataStore()
        )
    )
    
}
