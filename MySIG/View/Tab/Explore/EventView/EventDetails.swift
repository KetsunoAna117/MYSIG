//
//  EventDetails.swift
//  MySIG
//
//  Created by Tania Cresentia on 07/04/24.
//

import SwiftUI

struct EventDetails: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @State var toggleValue = false
    var selectedEvent: EventSIG
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
//                ScrollView{ <- ga tau kenapa kalau pakai ini list participants malah ilang O.o
                List{
                    HStack{
                        Rectangle()
                            .frame(width: 3, height: 50)
                            .foregroundColor(Constants.Orange)
                        Text("\(selectedEvent.name)")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 20)
                        Spacer()
                        Text("1 available slots")
                            .font(.subheadline)
                            .foregroundColor(Constants.Red)
                    }
                    .padding([.leading, .trailing], 15)
                    
                    Text("\(selectedEvent.desc)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.leading, 15)
                    
                    List{
                        HStack{
                            Text("Location")
                                .font(.headline)
                            Spacer()
                            Text("\(selectedEvent.location)")
                                .font(.footnote)
                        }
                        HStack{
                            Text("Date")
                                .font(.headline)
                            Spacer()
                            //                    Text("\(selectedEvent.date)")
                            //                        .font(.footnote)
                            
                            //THE DATEEE FORMATT!!!!
                        }
                        HStack{
                            Text("Time")
                                .font(.headline)
                            Spacer()
                            Text("\(selectedEvent.time) WIB")
                                .font(.footnote)
                        }
                        HStack{
                            Text("Max Slots")
                                .font(.headline)
                            Spacer()
                            Text("\(selectedEvent.maxSlots) Participants")
                                .font(.footnote)
                        }
                        HStack{
                            NavigationLink{
                                SIGDetails(selectedSIG: AppDataStore().sigs[selectedEvent.sigId])
                                
                                //THE SIG OF THE SELECTEDEVENT????
                            } label: {
                                Text("Badminton")
                                    .font(.headline)
                                    .foregroundColor(Constants.Orange)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: 250)
                    
                    Text("Registered Participants")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.leading, 15)
                        .padding(.bottom, -10)
                    
                    ParticipantListView(participantList: Utils().getUsersRegisteredForEvent(eventData: AppDataStore().events[0], appStoreData: AppDataStore()))
                        .padding(.leading, 10)
                        .frame(height: 500)
                    
//                    Spacer()
                }
                .listStyle(.plain)
                .padding(-20)
                
                VStack{
                    Divider()
                    HStack{
                        Text("Remind me")
                        Image(systemName: "info.circle")
                            .foregroundColor(Constants.Orange)
                        Spacer()
                        Toggle(isOn: $toggleValue) {
                            
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Constants.Orange))
                        .padding()
                    }
                    .padding(.leading, 7)
                    Button(action:{
                        //
                    }, label:{
                        Text("Book this event")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 360, height: 50)
                            .background(Color(red: 1, green: 0.675, blue: 0.36))
                            .cornerRadius(15)
                            .padding(.top, -10)
                    })
                }
                .background(.white)
            }
            .padding()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EventDetails(selectedEvent: AppDataStore().events[0])
        .environmentObject(AppDataStore())
}
