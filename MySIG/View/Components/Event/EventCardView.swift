//
//  CardView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct EventCardView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    let event: EventSIG
    
    
    var body: some View {
        let time = event.time.components(separatedBy: "-")
        let dayName: String = String(Utils().getDayName(from: event.date ?? Date.now).prefix(3))
        let day = Utils().getDay(from: event.date ?? Date.now)
        let month = Utils().getMonth(from: event.date ?? Date.now)
        
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 160)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 1)
            
            HStack(alignment: VerticalAlignment.center){
                VStack() {
                    ZStack {
                        if let user = appDataStore.currentActiveUser {
                            let userBookedThisEvent = Utils().checkIfUserBookEvent(
                                event: event,
                                user: user
                            )
                            
                            Image(userBookedThisEvent ? "EventCard-TimeBackground-Booked" : "EventCard-TimeBackground")
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(maxWidth: 30, maxHeight: 35)
                        }
                        Text(time[0])
                            .font(
                                Font.custom("SF Pro Rounded", size: 12)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .frame(width: 57.99698, height: 15, alignment: .center)
                            .padding(.bottom, 10)
                    }
                    
                    VStack(spacing: 1) {
                        if let user = appDataStore.currentActiveUser {
                            let userBookedThisEvent = Utils().checkIfUserBookEvent(
                                event: event,
                                user: user
                            )
                            
                            Text(dayName.uppercased())
                                .font(
                                    Font.custom("SF Pro Rounded", size: 12)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(userBookedThisEvent ? Constants.Purple : .accentColor)
                                .frame(width: 33.42199, height: 15, alignment: .center)
                            
                            Text("\(day)")
                                .font(
                                    Font.custom("SF Pro Rounded", size: 36)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(userBookedThisEvent ? Constants.Purple : .accentColor)
                                .frame(width: 59.96298, height: 34, alignment: .center)
                            
                            Text("\(month)")
                                .font(
                                    Font.custom("SF Pro Rounded", size: 12)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(userBookedThisEvent ? Constants.Purple : .accentColor)
                                .frame(width: 38.33698, height: 15, alignment: .center)
                            
                        }
                    }
                    
                }
                .padding(.top, -50)
                .padding(.trailing, 15)
                .padding(.leading, 20)
                
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1, height: 80)
                    .background(Color.secondary)
                    .padding(.trailing, 8)
                
                VStack (alignment: .leading){
                    Spacer()
                    Text(event.name)
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 200, alignment: .leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    VStack (alignment: .leading){
                        HStack{
                            if let foundSIG: SIG = Utils().getSigById(
                                sigId: event.sigId,
                                appStoreData: appDataStore){
                                Image(systemName: "paperclip")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12, height: 12)
                                Text("SIG \(foundSIG.name)")
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("SF Pro", size: 12))
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 11, alignment: .leading)
                            }
                        }
                        .padding(.bottom, 1)
                        HStack{
                            Image(systemName: "pin.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12)
                            Text(event.location)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .font(Font.custom("SF Pro", size: 12))
                                .foregroundColor(.black)
                                .frame(width: 150, alignment: .leading)
                        }
                    }
                    Spacer()
                }
                
                Spacer()
            }
            
            if let user = appDataStore.currentActiveUser {
                let userBookedThisEvent = Utils().checkIfUserBookEvent(
                    event: event,
                    user: user
                )
                
                let remainingSlot = Utils().calculateRemainingSlot(event: event)
                if userBookedThisEvent == false &&  remainingSlot > 0 {
                    ZStack {
                        Image("EventCard-SlotBackground")
                            .resizable()
                            .frame(
                                maxWidth: 125,
                                maxHeight: 30,
                                alignment:.leading
                            )
                        
                        Text("\(remainingSlot) remaining slot")
                            .font(
                                Font.custom("SF Pro", size: 12)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color.white)
                        
                        
                        Button(action: {
                            print("user book the event: \(Utils().checkIfUserBookEvent(event: event, user: user))")
                        }, label: {
                            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        })
                    }
                    .padding(.trailing, 5)
                }
            }
            
            
        }
        .frame(height: 160)
    }
}

#Preview {
    EventCardView(event: AppDataStore().events[0])
        .environmentObject(AppDataStore())
}
