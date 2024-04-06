//
//  EventListView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 04/04/24.
//

import SwiftUI

struct ExploreEventView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @Binding var searchedText: String

    @State var eventList: [EventSIG]
    
    var filteredEventList: [EventSIG] {
        if(searchedText.isEmpty == false){
            return eventList.filter { event in
                Utils().getSigById(sigId: event.sigId, appStoreData: appDataStore)?.name.contains(searchedText) ?? false ||
                event.name.contains(searchedText) ||
                event.location.contains(searchedText)
            }
        }
        return eventList
    }
    
    var body: some View {
        VStack {
//            EventListView(eventList: filteredEventList)
            
            List {
                ForEach(filteredEventList, id: \.self) { event in
                    EventCardView(event: event)
    //                    .listRowInsets(EdgeInsets())
                        .environmentObject(appDataStore)
                        .background(
                            NavigationLink(
                                destination: EventDetails(selectedEvent: event),
                                label: {
                                    Text("View Details")
                                        .foregroundColor(.blue)
                                        .font(.subheadline)
                                }
                            )
                        )
                }
            }
            .listStyle(.plain)
            .listRowSpacing(10)
            
        }
    }
}

#Preview {
    ExploreEventView(searchedText: .constant(""), eventList: AppDataStore().events)
        .environmentObject(AppDataStore())
}
