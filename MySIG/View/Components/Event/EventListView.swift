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
        if appStoreData.currentActiveUser != nil{
            if eventList.isEmpty == false {
                VStack {
                    ForEach(eventList, id: \.self) { anEvent in
                        NavigationLink(destination: {
                            EventDetails(selectedEvent: anEvent)
                                .environmentObject(appStoreData)
                        }, label: {
                            EventCardView(event: anEvent)
                        })
                    }
                }
            } else {
                Text("You haven't book any event...")
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EventListView(
            eventList: Utils().getEventListFromSIG(sigId: 1, appStoreData: AppDataStore())
        )
        .environmentObject(AppDataStore())
    }
    
}
