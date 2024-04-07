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
    @State private var notificationDetent = PresentationDetent.medium
    @State private var haveNotificaton = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                        if(haveNotificaton == false){
                            Image(systemName: "bell")
                        }
                        else{
                            Image(systemName: "bell.badge")
                        }
                    })
                })
                .sheet(isPresented: $showNotification, content: {
                    NotificationView()
                        .presentationDetents(
                            [.medium, .large],
                            selection: $notificationDetent
                        )
            })
            }
            //        .padding(.horizontal, 16)
        }
        .onChange(
            of: appDataStore.currentActiveUser,
            {
                if(appDataStore.currentActiveUser?.notificationId.isEmpty == true){
                    haveNotificaton = false
                }
                else{
                    haveNotificaton = true
                }
            })
        .onAppear(){
            if let user = appDataStore.currentActiveUser {
                haveNotificaton = user.notificationId.isEmpty ? false : true
            }
        }
    }
}

#Preview {
    NavigationStack{
        BookedEventView()
            .environmentObject(AppDataStore())
    }
    
}
