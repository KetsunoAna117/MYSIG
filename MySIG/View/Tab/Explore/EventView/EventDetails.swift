//
//  EventDetails.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 07/04/24.
//

import SwiftUI

struct EventDetails: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    @State var selectedEvent: EventSIG
    @State var currentActiveUser: User
    
    @State private var showModal = false
    @State private var descDetent = PresentationDetent.medium
    @State private var isUserAskForNotified = false
    @State private var isInfoButtonClicked = false
    
    @State private var isBooked = false
    @State private var buttonText = "Book This Event"
    
    var body: some View {
        let dayName: String = String(Utils().getDayName(from: selectedEvent.date ?? Date.now).prefix(3))
        let day = Utils().getDay(from: selectedEvent.date ?? Date.now)
        let month = Utils().getMonth(from: selectedEvent.date ?? Date.now)
        let year = Utils().getYear(from: selectedEvent.date ?? Date.now)
        
        VStack(alignment: .center) {
            ScrollView {
                VStack(alignment: .leading, content: {
                    HStack(alignment: .center){
                        HStack(spacing: 20) {
                            Rectangle()
                                .foregroundColor(.accentColor)
                                .frame(width: 3, height: 32)
                                .cornerRadius(2)
                            
                            Text(selectedEvent.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(width: 200, alignment: .leading)
                        }
                        
                        Spacer()
                        let remainingSlot = Utils().calculateRemainingSlot(event: selectedEvent)
                        Text("\(remainingSlot) remaining slot")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Constants.Red)
                    }
                    .padding(.bottom, 5)
                    
                    Text("\(selectedEvent.desc)")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                        .padding(.bottom, 20)
                        .lineLimit(4)
                        .truncationMode(.tail)
                        .onTapGesture {
                            self.showModal = true
                        }
                        .sheet(isPresented: $showModal) {
                            NavigationStack {
                                ScrollView {
                                    Text("\(selectedEvent.desc)")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .navigationTitle("Description")
                                .navigationBarTitleDisplayMode(.inline)
                                .padding(.horizontal, 16)
                            }
                            .presentationDetents(
                                [.medium, .large],
                                selection: $descDetent
                            )
                            
                        }
                    
                    VStack {
                        List {
                            InformationRowView(
                                informationIcon: "mappin",
                                informationType: "Location",
                                informationData: selectedEvent.location)
                            InformationRowView(
                                informationIcon: "calendar",
                                informationType: "Date",
                                informationData: "\(dayName), \(day) \(month) \(year)")
                            InformationRowView(
                                informationIcon: "clock",
                                informationType: "Time",
                                informationData: selectedEvent.time)
                            InformationRowView(
                                informationIcon: "person",
                                informationType: "Max Slot",
                                informationData: "\(selectedEvent.maxSlots)")
                            
                            if let sig = Utils().getSigById(
                                sigId: selectedEvent.sigId,
                                appStoreData: appStoreData) {
                                
                                NavigationLink {
                                    SIGDetails(selectedSIG: sig)
                                        .environmentObject(appStoreData)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text("SIG \(sig.name)")
                                            .foregroundStyle(Color.accentColor)
                                    }
                                }
                            }
                        }
                        .frame(height: 230)
                        .padding(.top, -10)
                        .scrollDisabled(true)
                        .listStyle(.plain)
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Registered Participants")
                            .font(.title3)
                            .fontWeight(.bold)
                        let users = Utils().getUsersRegisteredForEvent(
                            eventData: selectedEvent,
                            appStoreData: appStoreData)
                        
                        ParticipantListView(participantList: users, sigId: selectedEvent.sigId)
                            .environmentObject(appStoreData)
                    }
                })
                .padding(.horizontal, 16)
            }
            
            
            Spacer()
            Divider()
                .frame(height: 1)
            VStack (alignment: .leading) {
                HStack {
                    HStack {
                        Text("Remind me")
                            .font(.body)
                            .fontWeight(.bold)
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.accentColor)
                            .onTapGesture {
                                self.isInfoButtonClicked.toggle()
                            }
                            .popover(
                                isPresented: $isInfoButtonClicked,
                                attachmentAnchor: .point(.top),
                                arrowEdge: .top,
                                content: {
                                    if(isUserAskForNotified){
                                        VStack {
                                            Text("You will be notified")
                                            Text("before the event!")
                                        }
                                        .multilineTextAlignment(.center)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.accentColor)
                                        .font(.caption)
                                        .padding()
                                        .presentationCompactAdaptation(.none)
                                    }
                                    else {
                                        VStack {
                                            Text("You won't notified")
                                            Text("before the event")
                                        }
                                        .multilineTextAlignment(.center)
                                        .lineLimit(0)
                                        .foregroundStyle(Color.accentColor)
                                        .font(.caption)
                                        .padding()
                                        .presentationCompactAdaptation(.none)
                                    }
                                })
                    }
                    Spacer()
                    Toggle("", isOn: $isUserAskForNotified)
                        .tint(Color.accentColor)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            
            Button(action: {
                if (!isBooked){
                    Utils().addEventToUser($currentActiveUser, $selectedEvent)
                    buttonText = "Unbook Event"
                } else {
                    Utils().removeEventFromUser($currentActiveUser, $selectedEvent)
                    buttonText = "Book This Event"
                }
                
                isBooked.toggle()
                
            }, label: {
                
                Text("\(buttonText)")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .buttonStyle(.borderedProminent)
            .tint(isBooked ? Constants.Purple : Constants.Orange)
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .onAppear{
                if let currentActiveUser = appStoreData.currentActiveUser {
                    isBooked = Utils().checkIfUserBookEvent(event: selectedEvent, user: currentActiveUser)
                }
                
                if(isBooked){
                    buttonText = "Unbook Event"
                } else {
                    buttonText = "Book This Event"
                }
            }
            
        }
        .padding(.vertical, 16)
        .navigationTitle("Event Description")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EventDetails(selectedEvent: AppDataStore().events[0], currentActiveUser: AppDataStore().users[0])
            .environmentObject(AppDataStore())
    }
}
