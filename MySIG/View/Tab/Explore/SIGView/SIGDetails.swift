//
//  SIGDetails.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct SIGDetails: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    let selectedSIG: SIG
    @State private var showModal = false
    @State private var isSubscribed = false
    
    @State private var descDetent = PresentationDetent.medium
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("\(selectedSIG.name.capitalized)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    
                    Text("\(selectedSIG.desc)")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                        .padding(.bottom, 10)
                        .lineLimit(4)
                        .truncationMode(.tail)
                        .onTapGesture {
                            self.showModal = true
                        }
                        .sheet(isPresented: $showModal) {
                            NavigationStack {
                                ScrollView {
                                    Text("\(selectedSIG.desc)")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .navigationTitle("Details")
                                .navigationBarTitleDisplayMode(.inline)
                                .padding(.horizontal, 16)
                            }
                            .presentationDetents(
                                [.medium, .large],
                                selection: $descDetent
                            )
                        }
                    
                    if let user = Utils().getUserFromSIG(
                        sigId: selectedSIG.id,
                        appStoreData: appDataStore) {
                        
                        List {
                            InformationRowView(
                                informationIcon: "person.fill",
                                informationType: "PIC",
                                informationData: user.name
                            )
                        }
                        .listStyle(.plain)
                        .frame(height: 45)
                    }
                    
                    VStack(alignment: .leading, content: {
                        HStack {
                            Text("Event List")
                                .font(.title3)
                            .fontWeight(.bold)
                            Spacer()
                            NavigationLink {
                                CreateEventView(selectedSIG: selectedSIG)
                                    .environmentObject(appDataStore)
                            } label: {
                                Image(systemName: "plus.app")
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                        
                        VStack(alignment: .center) {
                            let eventList = Utils().getAllEventFromListId(
                                eventIdList: selectedSIG.listEventId,
                                appStoreData: AppDataStore()
                            )
                            
                            if eventList.isEmpty {
                                Text("There's no event at the moment...")
                                    .font(.footnote)
                                    .foregroundStyle(Color.gray)
                                Spacer()
                            } else {
                                EventListView(eventList: eventList)
                            }
                            
                        }
                    })
                    .padding(.top, 30)
                    
                }
                .padding(.horizontal, 20)
            }
            
            
            Divider()
                .frame(height: 1)
            Button(action: {
                if let user = appDataStore.currentActiveUser {
                    
                    if isSubscribed == false {
                            let result = Utils().addParticipantToSIG(
                                userId: user.id,
                                sigId: selectedSIG.id,
                                appStoreData: appDataStore
                            )
                            
                            if result == true {
                                isSubscribed = true
                            }
                        }
                    else {
                        let result = Utils().removeParticipantFromSIG(
                            userId: user.id,
                            sigId: selectedSIG.id,
                            appStoreData: appDataStore
                        )
                        
                        if result == true {
                            isSubscribed = false
                        }
                    }
                }
            }, label: {
                Text(isSubscribed ? "Unsubscribe notification" : "Subscribe notification")
                    .font(.title2)
                    .frame(width: 350, height: 60)
                    .background(isSubscribed ? Constants.Purple : Constants.Orange)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .padding(.vertical, 10)
            })
            .onAppear{
                putAllData()
            }
            .onChange(of: isSubscribed) {
                putAllData()
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 16)
        .navigationTitle("SIG Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func putAllData(){
        if let currentActiveUser = appDataStore.currentActiveUser {
            if let selectedEvent = Utils().getSigById(
                sigId: selectedSIG.id,
                appStoreData: appDataStore
            ) {
                isSubscribed = Utils().checkIfUserSubscribedToSIG(
                    sigId: selectedSIG.id,
                    userId: currentActiveUser.id,
                    appStoreData: appDataStore
                )
//                
//                listEventParticipant = Utils().getUsersRegisteredForEvent(
//                    eventId: selectedEvent.id,
//                    appStoreData: appStoreData
//                )
            }
        }
    }
}

#Preview {
    NavigationStack{
        SIGDetails(selectedSIG: AppDataStore().sigs[0])
            .environmentObject(AppDataStore())
    }
}
