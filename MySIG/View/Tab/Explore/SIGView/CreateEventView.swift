//
//  CreateEventView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 11/04/24.
//

import SwiftUI
import Combine

struct CreateEventView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    let selectedSIG: SIG
    
    @State private var eventName = ""
    @State private var eventDesc = ""
    @State private var eventLocation = ""
    
    @State private var eventDate = Date.now
    @State private var eventStartingTime = Date()
    @State private var eventEndingTime = Date()
    @State private var maxSlots = ""
    @State private var isUserWantAutomaticallyCreateNewEvent = false
    @State private var isInfoButtonClicked = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                SIGCardView(sigData: selectedSIG)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                List {
                    Section(){
                        CustomTextField(saveTo: $eventName, title: "Event Name")
                        CustomTextField(saveTo: $eventDesc, title: "Event Description")
                        CustomTextField(saveTo: $maxSlots, title: "Max Slots")
                            .keyboardType(.numberPad)
                            .onReceive(Just(maxSlots)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.maxSlots = filtered
                                }
                            }
                    }
                    
                    Section() {
                        CustomTextField(saveTo: $eventLocation, title: "Location")
                        DatePicker(selection: $eventDate, displayedComponents: .date) {
                            Text("Select a date")
                        }
                        DatePicker(selection: $eventStartingTime, displayedComponents: .hourAndMinute) {
                            Text("Start time")
                        }
                        
                        DatePicker(selection: $eventEndingTime, displayedComponents: .hourAndMinute) {
                            Text("Finish time")
                        }
                    }
                }
                .listStyle(.grouped)
                
            }
            Spacer()
            Divider()
                .frame(height: 1)
            HStack {
                HStack {
                    Text("Create new event automatically")
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
                                VStack {
                                    Text("If this event slot is full,")
                                    Text("create new event automatically!")
                                }
                                .multilineTextAlignment(.center)
                                .lineLimit(0)
                                .foregroundStyle(Color.accentColor)
                                .font(.caption)
                                .padding()
                                .presentationCompactAdaptation(.none)
                            })
                }
                Spacer()
                Toggle("", isOn: $isUserWantAutomaticallyCreateNewEvent)
                    .tint(Color.accentColor)
                
            }
            .padding(.top, 10)
            Button(action: {
                // create new event SIG
            }, label: {
                Text("Create new event")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            })
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 16)
        .navigationTitle("Create new event")
    }
}

#Preview {
    NavigationStack {
        CreateEventView(selectedSIG: AppDataStore().sigs[0])
            .environmentObject(AppDataStore())
    }
}
