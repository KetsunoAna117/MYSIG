//
//  BookedEventView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct BookedEventView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @State private var showNotification = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let currentActiveUser = appDataStore.currentActiveUser {
                    let eventList = Utils().getAllEventFromListId(
                        eventIdList: currentActiveUser.bookedEventId,
                        appStoreData: appDataStore
                    )
                    EventListView(eventList: eventList)
                }
            }
            .navigationTitle("Booked Event")
            .padding(.top, 10)
            .listStyle(.plain)
            .listRowSpacing(10)
            .toolbar(content: {
                Button(action: {
                    showNotification.toggle()
                }, label: {
                    if(appDataStore.currentActiveUser?.notificationId.isEmpty == true){
                        Image(systemName: "bell")
                    }
                    else{
                        Image(systemName: "bell.badge")
                    }
                })
            })
//        .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NavigationStack{
        BookedEventView()
            .environmentObject(AppDataStore())
    }

}
